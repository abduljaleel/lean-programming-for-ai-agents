-- Book listing around line 3059 (Ch06_PropTactics).
example (p : Nat → Prop) : ∀ n, p n → p n := by
  intro n h
  exact h
