-- Book listing around line 2145 (Ch05_DoMonads).
def readLine : IO String := do
  let stdin ← IO.getStdin
  stdin.getLine

def say (s : String) : IO Unit :=
  IO.println s

def die (code : UInt32) (msg : String) : IO UInt32 := do
  IO.eprintln msg
  return code
