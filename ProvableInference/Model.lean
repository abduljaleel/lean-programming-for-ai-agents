/- Chapters 20 and 22. A toy integer mixture-of-experts
    layer with greedy decoding, and a trace checker in
    the shape of FlashProve's simplified online checks:
    (a) each step, (b) the argmax router, (c) ranges,
    (d) the greedy token. The checker here re-reads the
    whole trace, so it is sound but not succinct. A real
    IOP checks the same equations through commitments,
    sumcheck, and lookups. -/
namespace PI.Model

abbrev Vec := List Int
abbrev Mat := List Vec

def dot (a b : Vec) : Int := (List.zipWith (· * ·) a b).foldl (· + ·) 0
def matVec (W : Mat) (x : Vec) : Vec := W.map (dot · x)
def vadd (a b : Vec) : Vec := List.zipWith (· + ·) a b

/-- `i` is the FIRST index of a maximal entry. Fixing
    the tie-break is what makes greedy decoding a
    function rather than a relation. -/
def FirstArgmax (l : Vec) (i : Nat) : Prop :=
  i < l.length ∧ ∀ j, j < l.length → l[j]! ≤ l[i]! ∧ (j < i → l[j]! < l[i]!)

instance (l : Vec) (i : Nat) : Decidable (FirstArgmax l i) := by
  unfold FirstArgmax; exact inferInstance

/-- There is at most one first argmax. This is the
    property that rules out "two acceptable answers"
    under greedy decoding. -/
theorem firstArgmax_unique (l : Vec) (i j : Nat)
    (hi : FirstArgmax l i) (hj : FirstArgmax l j) : i = j := by
  rcases Nat.lt_trichotomy i j with h | h | h
  · have h1 := (hj.2 i hi.1).2 h
    have h2 := (hi.2 j hj.1).1
    omega
  · exact h
  · have h1 := (hi.2 j hj.1).2 h
    have h2 := (hj.2 i hi.1).1
    omega

/-- Compute an argmax by search. Total; returns 0 on the
    empty list. -/
def argmax (l : Vec) : Nat :=
  ((List.range l.length).find? (fun i => decide (FirstArgmax l i))).getD 0

/-- Field-style range: values live in (-p/2, p/2), as in
    FlashProve's integer model. -/
def InRange (half : Int) (v : Vec) : Prop := ∀ x ∈ v, -half < x ∧ x < half

instance (half : Int) (v : Vec) : Decidable (InRange half v) := by
  unfold InRange; exact inferInstance

structure Model where
  router  : Mat          -- one row per expert
  experts : List Mat     -- one matrix per expert
  shared  : Mat          -- always-on shared expert
  unembed : Mat          -- one row per vocabulary item

/-- The values a prover claims it computed. -/
structure Trace where
  scores : Vec
  expert : Nat
  hidden : Vec
  logits : Vec
  token  : Nat
  deriving Repr, DecidableEq

def Model.run (M : Model) (x : Vec) : Trace :=
  let s := matVec M.router x
  let e := argmax s
  let h := vadd (matVec (M.experts.getD e []) x) (matVec M.shared x)
  let z := matVec M.unembed h
  { scores := s, expert := e, hidden := h, logits := z, token := argmax z }

/-- The specification of a correct greedy step, written
    as a relation. -/
def StepSpec (M : Model) (half : Int) (x : Vec) (t : Trace) : Prop :=
  -- (a)
  t.scores = matVec M.router x ∧
  -- (b)
  FirstArgmax t.scores t.expert ∧
  -- (a)
  t.hidden = vadd (matVec (M.experts.getD t.expert []) x) (matVec M.shared x) ∧
  -- (a)
  t.logits = matVec M.unembed t.hidden ∧
  -- (c)
  InRange half t.hidden ∧ InRange half t.logits ∧
  -- (d)
  FirstArgmax t.logits t.token

instance (M : Model) (half : Int) (x : Vec) (t : Trace) : Decidable (StepSpec M half x t) := by
  unfold StepSpec; exact inferInstance

/-- The checker is the decision procedure for the spec. -/
def checkTrace (M : Model) (half : Int) (x : Vec) (t : Trace) : Bool :=
  decide (StepSpec M half x t)

theorem checkTrace_sound (M : Model) (half : Int) (x : Vec) (t : Trace)
    (h : checkTrace M half x t = true) : StepSpec M half x t :=
  of_decide_eq_true h

/-- Two accepted traces for the same input name the same
    expert and the same token. A provider cannot pass
    off a different answer. -/
theorem accepted_token_unique (M : Model) (half : Int) (x : Vec) (t u : Trace)
    (ht : checkTrace M half x t = true) (hu : checkTrace M half x u = true) :
    t.expert = u.expert ∧ t.token = u.token := by
  have st := checkTrace_sound M half x t ht
  have su := checkTrace_sound M half x u hu
  have he : t.expert = u.expert := by
    apply firstArgmax_unique t.scores
    · exact st.2.1
    · rw [st.1, ← su.1]; exact su.2.1
  refine ⟨he, ?_⟩
  have hh : t.hidden = u.hidden := by rw [st.2.2.1, su.2.2.1, he]
  have hl : t.logits = u.logits := by rw [st.2.2.2.1, su.2.2.2.1, hh]
  apply firstArgmax_unique t.logits
  · exact st.2.2.2.2.2.2
  · rw [hl]; exact su.2.2.2.2.2.2

/-- A two-expert, three-token toy. -/
def toy : Model where
  router  := [[1, 0], [0, 1]]
  experts := [ [[2, 0], [0, 1]], [[0, 1], [1, 0]] ]
  shared  := [[1, 1], [0, 1]]
  unembed := [[1, 0], [0, 1], [1, 1]]

#eval toy.run [3, 1]
-- true
#eval checkTrace toy 32768 [3, 1] (toy.run [3, 1])
-- false
#eval checkTrace toy 32768 [3, 1] { toy.run [3, 1] with token := 0 }
-- false: out of range, imperfect completeness
#eval checkTrace toy 4 [3, 1] (toy.run [3, 1])

end PI.Model
