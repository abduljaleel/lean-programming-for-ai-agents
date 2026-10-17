-- Book listing around line 8391 (Ch15_Autoformalization).
inductive Json where
  | null
  | bool : Bool → Json
  | num  : Int → Json
  | str  : String → Json
  | arr  : List Json → Json
  | obj  : List (String × Json) → Json
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

class Capable (α : Type) where
  name    : String
  allowed : α → Bool
