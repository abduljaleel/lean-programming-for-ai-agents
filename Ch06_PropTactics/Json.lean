-- Book listing around line 2943 (Ch06_PropTactics).
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
  | step  : ToolCall → ToolResult String → Trace → Trace
deriving Repr
