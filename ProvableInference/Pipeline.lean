/- Chapter 23. An agent pipeline that refuses unproved
    model output. The proof system is a parameter. What
    the pipeline guarantees is stated relative to an
    explicit soundness hypothesis. -/
namespace PI.Pipeline

/-- What a provider returns with each completion. -/
structure Receipt where
  -- commitment to the weights (offline phase)
  modelCommit : UInt64
  promptHash  : UInt64
  output      : String
  -- opaque bytes; the verifier reads them
  proof       : List UInt8
  deriving Repr

/-- The public statement a proof is about. -/
structure Stmt where
  modelCommit : UInt64
  promptHash  : UInt64
  output      : String
  deriving Repr, DecidableEq

def Receipt.stmt (r : Receipt) : Stmt := ⟨r.modelCommit, r.promptHash, r.output⟩

/-- A verifier is just a Boolean function of statement
    and proof. -/
abbrev Verifier := Stmt → List UInt8 → Bool

/-- The relation the proof system is meant to certify,
    e.g. "output is the greedy completion of the
    committed model on the prompt". Kept abstract here;
    Chapter 22 builds a toy one. -/
abbrev Rel := Stmt → Prop

/-- Soundness as a hypothesis the pipeline is
    parameterised by. For a real argument system this
    holds only except with tiny probability, under the
    random oracle model; see Chapter 21. -/
def SoundFor (V : Verifier) (R : Rel) : Prop :=
  ∀ s π, V s π = true → R s

structure Policy where
  -- model commitments an auditor signed off
  approved : List UInt64

/-- The only way to obtain a `Checked` value is `admit`. -/
structure Checked (V : Verifier) (P : Policy) where
  receipt  : Receipt
  approved : receipt.modelCommit ∈ P.approved
  verified : V receipt.stmt receipt.proof = true

inductive Refusal where
  | unapprovedModel (c : UInt64)
  | promptMismatch
  | badProof
  deriving Repr

def admit (V : Verifier) (P : Policy) (expectPrompt : UInt64) (r : Receipt) :
    Except Refusal (Checked V P) :=
  if hc : r.modelCommit ∈ P.approved then
    if r.promptHash ≠ expectPrompt then .error .promptMismatch
    else if hv : V r.stmt r.proof = true then .ok ⟨r, hc, hv⟩
    else .error .badProof
  else .error (.unapprovedModel r.modelCommit)

/-- Downstream tools take `Checked`, never a bare
    `Receipt`. -/
def actOn {V P} (c : Checked V P) : String := s!"executing plan: {c.receipt.output}"

/-- What the pipeline buys you, stated honestly: if the
    verifier is sound for `R`, every admitted output
    satisfies `R` and came from an approved commitment
    with the prompt you sent. -/
theorem admitted_correct (V : Verifier) (R : Rel) (P : Policy) (hV : SoundFor V R)
    (p : UInt64) (r : Receipt) (c : Checked V P) (h : admit V P p r = .ok c) :
    R c.receipt.stmt ∧ c.receipt.modelCommit ∈ P.approved ∧ c.receipt.promptHash = p := by
  unfold admit at h
  split at h
  · split at h
    · cases h
    · split at h
      · cases h
        rename_i hp _
        exact ⟨hV _ _ (by assumption), by assumption, by simpa using hp⟩
      · cases h
  · cases h

/-- A silent model swap is refused before the proof is
    even read. -/
example : ∀ V (r : Receipt), r.modelCommit = 99 →
    (admit V ⟨[1, 2, 3]⟩ r.promptHash r) = .error (.unapprovedModel 99) := by
  intro V r h
  simp [admit, h]

/-- A demo verifier that accepts nothing, to exercise
    the refusal path. -/
def rejectAll : Verifier := fun _ _ => false

#eval match admit rejectAll ⟨[7]⟩ 1 ⟨7, 1, "rm -rf build/", []⟩ with
  | .ok c    => actOn c
  | .error e => s!"refused: {repr e}"

end PI.Pipeline
