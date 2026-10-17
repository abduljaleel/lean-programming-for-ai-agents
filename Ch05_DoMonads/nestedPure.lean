-- Book listing around line 2480 (Ch05_DoMonads).
def nestedPure : IO Nat := do
  let x ← (do
    if True then
      pure 1            -- value-return from the nested block
    else
      pure 2)
  return x + 10
-- 11

def nestedParens : IO Nat := do
  let x ← ((do
    if True then
      return 1          -- return is now scoped to the parenthesized do
    pure 2))
  return x + 10
-- 11
