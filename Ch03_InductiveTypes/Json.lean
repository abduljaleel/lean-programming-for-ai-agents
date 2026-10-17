-- Book listing around line 966 (Ch03_InductiveTypes).
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
