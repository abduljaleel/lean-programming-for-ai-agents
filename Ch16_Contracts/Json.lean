-- Book listing around line 8813 (Ch16_Contracts).
import Lean
/-- Pedagogical JSON. Production code can use `Lean.Json`. -/
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

inductive Trace where
  | nil
  | cons : ToolCall → ToolResult Json → Trace → Trace
deriving Repr, Inhabited
