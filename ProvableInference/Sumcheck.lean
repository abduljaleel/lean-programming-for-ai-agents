/- Chapter 21. Sumcheck for multilinear polynomials,
    over the integers. Completeness is proved for every
    polynomial and every challenge list. The per-round
    soundness fact (two different lines meet at most
    once) is proved too. The field-size error bound is
    stated in prose. -/
namespace PI.Sumcheck

/-- A multilinear polynomial in `n` variables, stored as
    its two restrictions to x₀ = 0 and x₀ = 1. -/
inductive ML : Nat → Type where
  | const : Int → ML 0
  | split : ML n → ML n → ML (n + 1)

/-- Evaluate at a point. Missing coordinates read as 0. -/
def ML.eval : ML n → List Int → Int
  | .const c,   _       => c
  | .split p q, []      => p.eval []
  | .split p q, r :: rs => (1 - r) * p.eval rs + r * q.eval rs

/-- Sum over the Boolean hypercube {0,1}ⁿ. -/
def ML.hsum : ML n → Int
  | .const c   => c
  | .split p q => p.hsum + q.hsum

/-- Fix the first variable at `r`: combine the two
    halves pointwise. -/
def ML.comb (r : Int) : ML n → ML n → ML n
  | .const a,   .const b   => .const ((1 - r) * a + r * b)
  | .split a b, .split c d => .split (ML.comb r a c) (ML.comb r b d)

theorem ML.hsum_comb (r : Int) : ∀ (p q : ML n),
    (ML.comb r p q).hsum = (1 - r) * p.hsum + r * q.hsum
  | .const a,   .const b   => by simp [ML.comb, ML.hsum]
  | .split a b, .split c d => by
      simp only [ML.comb, ML.hsum, ML.hsum_comb r a c, ML.hsum_comb r b d]
      grind

theorem ML.eval_comb (r : Int) : ∀ (p q : ML n) (ys : List Int),
    (ML.comb r p q).eval ys = (1 - r) * p.eval ys + r * q.eval ys
  | .const a,   .const b,   _       => by simp [ML.comb, ML.eval]
  | .split a b, .split c d, []      => by simp [ML.comb, ML.eval, ML.eval_comb r a c]
  | .split a b, .split c d, y :: ys => by
      simp only [ML.comb, ML.eval, ML.eval_comb r a c, ML.eval_comb r b d]
      grind

/-- A prover message for one round: the round polynomial
    at 0 and 1. -/
abbrev Msg := Int × Int

/-- Evaluate the line through (0, a₀) and (1, a₁) at
    `r`. -/
def line (m : Msg) (r : Int) : Int := m.1 + r * (m.2 - m.1)

/-- The verifier. It never sees the polynomial, only an
    oracle for one evaluation at the end (in FlashProve,
    a commitment opening). -/
def check (oracle : List Int → Int) : Int → List Msg → List Int → List Int → Bool
  | claim, [],       [],      acc => claim == oracle acc.reverse
  | claim, m :: ms,  r :: rs, acc =>
      (m.1 + m.2 == claim) && check oracle (line m r) ms rs (r :: acc)
  | _, _, _, _ => false

/-- The honest prover. -/
def honest : ML n → List Int → List Msg
  | .split p q, r :: rs => (p.hsum, q.hsum) :: honest (ML.comb r p q) rs
  | _, _ => []

/-- Completeness, generalised over the challenges
    already fixed. -/
theorem complete_aux : ∀ (p : ML n) (rs acc : List Int) (O : List Int → Int),
    rs.length = n → (∀ ys, O (acc.reverse ++ ys) = p.eval ys) →
    check O p.hsum (honest p rs) rs acc = true
  | .const c, [], acc, O, _, hO => by
      have := hO []
      simp_all [check, honest, ML.hsum, ML.eval]
  | .split p q, r :: rs, acc, O, hl, hO => by
      simp only [honest, check, Bool.and_eq_true, beq_iff_eq]
      refine ⟨by simp [ML.hsum], ?_⟩
      have hline : line (p.hsum, q.hsum) r = (ML.comb r p q).hsum := by
        rw [ML.hsum_comb]; simp [line]; grind
      rw [hline]
      apply complete_aux (ML.comb r p q) rs (r :: acc) O (by simpa using hl)
      intro ys
      have := hO (r :: ys)
      simp only [List.reverse_cons, List.append_assoc, List.singleton_append] at *
      rw [this, ML.eval_comb]; simp [ML.eval]

/-- Perfect completeness: for every challenge list of
    the right length, the honest prover's true sum is
    accepted. -/
theorem complete (p : ML n) (rs : List Int) (h : rs.length = n) :
    check p.eval p.hsum (honest p rs) rs [] = true :=
  complete_aux p rs [] p.eval h (by intro ys; simp)

/-- The heart of soundness, one round: two different
    lines agree at no more than one challenge. Over a
    field 𝔽 this gives a cheating prover at most 1/|𝔽|
    chance per round (d/|𝔽| for degree d). -/
theorem lines_meet_once (a b : Msg) (hne : a ≠ b) (r s : Int)
    (hr : line a r = line b r) (hs : line a s = line b s) : r = s := by
  obtain ⟨a0, a1⟩ := a
  obtain ⟨b0, b1⟩ := b
  simp only [line] at hr hs
  by_cases h0 : a0 = b0
  · subst h0
    have h1 : a1 ≠ b1 := by intro h; exact hne (by simp [h])
    have hr' : r * (a1 - b1) = 0 := by grind
    have hs' : s * (a1 - b1) = 0 := by grind
    have hd : a1 - b1 ≠ 0 := by omega
    have : r = 0 := by
      rcases Int.mul_eq_zero.mp hr' with h | h
      · exact h
      · exact absurd h hd
    have : s = 0 := by
      rcases Int.mul_eq_zero.mp hs' with h | h
      · exact h
      · exact absurd h hd
    omega
  · have key : (r - s) * ((a1 - a0) - (b1 - b0)) = 0 := by grind
    rcases Int.mul_eq_zero.mp key with h | h
    · omega
    · exfalso
      have : r * ((a1 - a0) - (b1 - b0)) = r * 0 := by rw [h]
      grind

/-- A 3-variable example: f = x₀ + 2·x₁·x₂, stored by
    halves. -/
def f3 : ML 3 :=
  .split (.split (.split (.const 0) (.const 0)) (.split (.const 0) (.const 2)))
         (.split (.split (.const 1) (.const 1)) (.split (.const 1) (.const 3)))

-- 8
#eval f3.hsum
-- true
#eval check f3.eval f3.hsum (honest f3 [5, 7, 11]) [5, 7, 11] []
-- false
#eval check f3.eval 7 (honest f3 [5, 7, 11]) [5, 7, 11] []

end PI.Sumcheck
