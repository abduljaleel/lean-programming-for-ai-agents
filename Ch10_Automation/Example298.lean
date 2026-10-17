-- Book listing around line 6032 (Ch10_Automation).
example (used quota : Nat) (h : used + 1 < quota) :
    used < quota ∧ quota - used ≥ 2 := by
  grind
