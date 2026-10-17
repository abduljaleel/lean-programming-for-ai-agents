-- Book listing around line 2998 (Ch06_PropTactics).
theorem and_swap (p q : Prop) : p ∧ q → q ∧ p := by
  intro h
  have hp : p := h.left
  have hq : q := h.right
  exact And.intro hq hp
