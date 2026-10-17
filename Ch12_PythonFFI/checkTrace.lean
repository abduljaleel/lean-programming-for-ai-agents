-- Book listing around line 7023 (Ch12_PythonFFI).
def checkTrace (steps : UInt32) (failed : UInt8) : Bool :=
  failed == 0 && steps ≤ 32

def TraceSafe (steps : UInt32) (failed : UInt8) : Prop :=
  failed = 0 ∧ steps.toNat ≤ 32

theorem checkTrace_correct (s : UInt32) (f : UInt8) :
    checkTrace s f = true ↔ TraceSafe s f := by
  simp [checkTrace, TraceSafe]
  -- 4.32: grind closes the boolean/Prop bridge on this shape
  grind
