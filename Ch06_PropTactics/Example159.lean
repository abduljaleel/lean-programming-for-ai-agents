-- Book listing around line 3143 (Ch06_PropTactics).
example (a b c : Nat) (h : a = b) : a + c = b + c := by
  rw [h]

example (a b : Nat) (h : a = b) : b = a := by
  rw [h]
