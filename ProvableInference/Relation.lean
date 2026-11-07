/- Chapter 20. Relations, verifiers, and the three
    properties. A toy argument system over a decidable
    relation. No Mathlib. -/
namespace PI

/-- A relation between public statements and private
    witnesses. -/
structure Relation where
  Stmt    : Type
  Witness : Type
  holds   : Stmt → Witness → Prop
  dec     : ∀ x w, Decidable (holds x w)

/-- A non-interactive argument system: a prover and a
    verifier, both deterministic once the randomness `ρ`
    is fixed. -/
structure ArgSystem (R : Relation) (Proof Rand : Type) where
  prove  : R.Stmt → R.Witness → Rand → Proof
  verify : R.Stmt → Proof → Rand → Bool

/-- Perfect completeness: the honest prover always
    convinces. -/
def Complete {R : Relation} {P ρ : Type} (A : ArgSystem R P ρ) : Prop :=
  ∀ x w r, R.holds x w → A.verify x (A.prove x w r) r = true

/-- Perfect soundness: if the verifier accepts, a
    witness exists. Real systems only get this up to an
    error term. -/
def Sound {R : Relation} {P ρ : Type} (A : ArgSystem R P ρ) : Prop :=
  ∀ x π r, A.verify x π r = true → ∃ w, R.holds x w

/-- The trivial system: the proof is the witness, the
    verifier re-checks. Complete and sound, but neither
    succinct nor zero-knowledge. -/
def trivialSystem (R : Relation) : ArgSystem R R.Witness Unit where
  prove  := fun _ w _ => w
  verify := fun x w _ => @decide (R.holds x w) (R.dec x w)

theorem trivial_complete (R : Relation) : Complete (trivialSystem R) := by
  intro x w r h
  simp [trivialSystem, h]

theorem trivial_sound (R : Relation) : Sound (trivialSystem R) := by
  intro x π r h
  exact ⟨π, by simpa [trivialSystem] using h⟩

/-- Example relation: "I know a factorisation of n with
    both factors > 1". -/
def Composite : Relation where
  Stmt    := Nat
  Witness := Nat × Nat
  holds   := fun n p => p.1 > 1 ∧ p.2 > 1 ∧ p.1 * p.2 = n
  dec     := fun _ _ => inferInstance

example : (trivialSystem Composite).verify (91 : Nat) ((7, 13) : Nat × Nat) () = true := by
  decide

end PI
