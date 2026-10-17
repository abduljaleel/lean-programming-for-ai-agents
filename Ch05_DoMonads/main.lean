-- Book listing around line 2133 (Ch05_DoMonads).
def main (args : List String) : IO UInt32 := do
  IO.println s!"hello, {args}!"
  return 0
