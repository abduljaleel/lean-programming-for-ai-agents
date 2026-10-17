-- Book listing around line 5736 (Ch10_Automation).
example (p q : Prop) (h : p ∧ q) : q ∧ p := by
  constructor
  · exact h.right
  · exact h.left
