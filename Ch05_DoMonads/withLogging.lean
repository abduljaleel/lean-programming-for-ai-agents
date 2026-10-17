-- Book listing around line 2511 (Ch05_DoMonads).
def withLogging [Monad m] [MonadLiftT IO m] (act : m α) : m α := do
  IO.println "log!"
  act

def mutForward : IO Nat := do
  let mut x := 0
  withLogging (do←
    x := x + 1)
  return x
-- prints "log!", returns 1
