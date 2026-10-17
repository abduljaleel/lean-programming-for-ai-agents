-- Book listing around line 5659 (Ch10_Automation).
structure AgentState where
  used  : Nat
  quota : Nat
deriving Repr

def AgentState.quotaLeft (s : AgentState) : Nat :=
  s.quota - s.used

example (s : AgentState) (h : s.used < s.quota) :
    s.quotaLeft ≠ 0 := by
  -- grind  -- often fails; quotaLeft is a def
  simp [AgentState.quotaLeft]
  grind
