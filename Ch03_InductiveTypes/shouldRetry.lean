-- Book listing around line 1009 (Ch03_InductiveTypes).

-- Preamble: earlier listings from this chapter this file needs.
-- Not part of the printed listing.

inductive Action where
  | read   (path : String)
  | write  (path : String) (contents : String)
  | shell  (cmd : String)
  | finish (summary : String)
deriving Repr, Inhabited, BEq

def step : Action := .read "src/Main.lean"
def done : Action := Action.finish "patched the timeout"

structure Json where
  raw : String
deriving Repr, BEq, Inhabited

structure ToolCall where
  name : String
  args : Json
deriving Repr, BEq, Inhabited

inductive ToolResult (α : Type) where
  | ok     : α → ToolResult α
  | denied : String → ToolResult α
  | failed : String → ToolResult α
deriving Repr

inductive Trace where
  | empty : Trace
  | step  : ToolCall → ToolResult Json → Trace → Trace
deriving Repr

def Trace.length : Trace → Nat
  | .empty       => 0
  | .step _ _ t  => 1 + t.length

def Trace.calls : Trace → List ToolCall
  | .empty         => []
  | .step c _ t    => c :: t.calls

def Trace.denied : Trace → Bool
  | .empty => false
  | .step _ (.denied _) _ => true
  | .step _ _ t => t.denied

-- Printed listing.

def shouldRetry {α : Type} : ToolResult α → Bool
  | .ok _        => false
  | .denied _    => false
  | .failed msg  => msg.startsWith "timeout" || msg.startsWith "429"
