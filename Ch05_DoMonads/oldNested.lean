-- Book listing around line 2467 (Ch05_DoMonads).
def oldNested : IO Nat := do
  let x ← (do
    if True then
      return 1          -- 4.32: returns from oldNested, not from the inner do
    pure 2)
  return x + 10
