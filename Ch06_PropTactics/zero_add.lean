-- Book listing around line 3239 (Ch06_PropTactics).
theorem zero_add (n : Nat) : 0 + n = n := by
  induction n with
  | zero =>
      rfl
  | succ n ih =>
      -- ih : 0 + n = n
      -- ⊢ 0 + (n + 1) = n + 1
      rw [Nat.add_succ, ih]
