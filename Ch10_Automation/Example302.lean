-- Book listing around line 6068 (Ch10_Automation).
-- grind on a lemma chain it does not E-match:
example (p q : Prop) (h : p ∧ q) : q ∧ p := by
  -- grind  -- may work via builtin And rules, or sit there
  constructor
  · exact h.right
  · exact h.left

-- aesop on a linear inequality it has no rule for:
example (n : Nat) (h : n + 2 < 8) : n < 6 := by
  -- aesop  -- fail or explode
  grind

-- simp on a goal that needs a constructor:
example (p q : Prop) (hp : p) (hq : q) : p ∧ q := by
  -- simp  -- will not apply And.intro
  exact ⟨hp, hq⟩

-- mvcgen on a pure Prop:
example (n : Nat) : 0 + n = n := by
  -- mvcgen  -- not a triple
  simp
