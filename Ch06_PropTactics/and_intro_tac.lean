-- Book listing around line 2988 (Ch06_PropTactics).
theorem and_intro_tac (p q : Prop) : p → q → p ∧ q := by
  intro hp hq
  exact And.intro hp hq
