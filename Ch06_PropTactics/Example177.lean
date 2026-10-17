-- Book listing around line 3508 (Ch06_PropTactics).
example (a b : Int) (h : a + 2 ≤ b) : a ≤ b := by
  omega

example (n : Nat) (h : n < 5) : n ≤ 4 := by
  omega
