-- Book listing around line 5531 (Ch10_Automation).
example (used quota : Nat) (h : used < quota) :
    used + 1 ≤ quota := by
  grind

example (used quota : Nat)
    (h1 : used ≤ quota) (h2 : used ≠ quota) :
    used < quota := by
  grind

example (n : Nat) (h : n < 5) : n ≤ 4 := by
  grind
