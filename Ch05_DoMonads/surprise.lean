-- Book listing around line 2885 (Ch05_DoMonads).
def surprise : IO Nat := do
  let x ← (do
    return 1)
  return x + 10
