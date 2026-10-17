-- Book listing around line 330 (Ch01_WhyLean).
def inSandbox (path : String) : Bool :=
  !path.isEmpty && !path.startsWith "/" && !path.contains ".."

inductive Action where
  | read  (path : String)
  | write (path : String) (contents : String)
  | done  (summary : String)
deriving Repr, BEq

def permitted : Action → Bool
  | .read path    => inSandbox path
  | .write path _ => inSandbox path
  | .done _       => true

def handle (a : Action) : Except String Action :=
  if permitted a then .ok a else .error "denied"

theorem handle_ok_means_permitted (a a' : Action)
    (h : handle a = .ok a') : permitted a' = true := by
  simp [handle] at h
  split at h
  · simp_all
  · contradiction
