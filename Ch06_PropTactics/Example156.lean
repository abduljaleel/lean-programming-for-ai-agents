-- Book listing around line 3100 (Ch06_PropTactics).
example (p q : Prop) (h : p → q) (hp : p) : q := by
  refine h ?_
  exact hp
