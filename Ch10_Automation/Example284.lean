-- Book listing around line 5795 (Ch10_Automation).
example (n : Nat) : 0 + n = n := by
  simp only [Nat.zero_add]
