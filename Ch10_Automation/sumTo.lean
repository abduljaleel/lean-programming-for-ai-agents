-- Book listing around line 5932 (Ch10_Automation).
def sumTo (n : Nat) : Id Nat := do
  let mut acc := 0
  for i in [:n] do
    acc := acc + i
  pure acc
