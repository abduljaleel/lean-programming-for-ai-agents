-- Book listing around line 3304 (Ch06_PropTactics).
example (a b : Nat) : a + b + 0 = a + b := by
  conv =>
    lhs
    rw [Nat.add_zero]
