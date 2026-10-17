-- Book listing around line 3090 (Ch06_PropTactics).
example (p q : Prop) (h : p → q) (hp : p) : q := by
  apply h
  exact hp
