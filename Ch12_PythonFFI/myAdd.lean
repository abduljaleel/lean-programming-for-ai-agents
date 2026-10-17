-- Book listing around line 6888 (Ch12_PythonFFI).
@[export my_add]
def myAdd (a b : UInt32) : UInt32 := a + b

inductive TraceOk where
  | yes
  | no
  deriving Inhabited

/-- FFI-flattened cousin of the Chapter 3 inductive. Crossing the ABI
    wants primitives, not `lean_object *`. -/
structure Trace where
  steps : UInt32
  failed : Bool

@[export check_trace]
def checkTrace (steps : UInt32) (failed : UInt8) : UInt8 :=
  if failed == 0 && steps ≤ 32 then 1 else 0
