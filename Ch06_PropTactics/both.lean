-- Book listing around line 3042 (Ch06_PropTactics).
theorem both (p q : Prop) (hp : p) (hq : q) : p ∧ q := by
  constructor
  · exact hp
  · exact hq
