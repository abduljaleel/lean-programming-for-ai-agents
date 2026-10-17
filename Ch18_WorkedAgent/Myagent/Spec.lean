-- Book listing around line 10221 (Ch18_WorkedAgent).
-- Myagent/Spec.lean
namespace Myagent

inductive Json where
  | null
  | bool : Bool → Json
  | num  : Int → Json
  | str  : String → Json
  | arr  : List Json → Json
  | obj  : List (String × Json) → Json
deriving Repr, BEq, Inhabited

def Json.getObj : Json → List (String × Json)
  | .obj kvs => kvs
  | _        => []

def Json.lookup (j : Json) (k : String) : Option Json :=
  j.getObj.lookup k

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

def Trace.length : Trace → Nat
  | .nil => 0
  | .cons _ _ t => t.length + 1

structure Contract (α : Type) where
  pre  : ToolCall → Prop
  run  : (c : ToolCall) → (h : pre c) → IO (ToolResult α)
  post : ToolCall → ToolResult α → Prop

/-- A capability is an instance, not a boolean flag. -/
class Capable (name : String) where
  contract : Contract Json
  checkPre : ToolCall → Bool
  checkPre_correct :
    ∀ c, c.name = name → checkPre c = true → contract.pre c

inductive Verdict where
  | accept
  | reject (reason : String)
  | abstain (reason : String)
deriving Repr

def Verdict.toExit : Verdict → UInt32
  | .accept    => 0
  | .reject _  => 1
  | .abstain _ => 3

def Verdict.toString : Verdict → String
  | .accept    => "ACCEPT"
  | .reject r  => s!"REJECT {r}"
  | .abstain r => s!"ABSTAIN {r}"

/-- Total stub. Unknown input becomes `.str s`. Never partial. -/
def parseJson (s : String) : Json :=
  if s == "null" then .null
  else if s == "true" then .bool true
  else if s == "false" then .bool false
  else if s.startsWith "\"" && s.endsWith "\"" && s.length >= 2 then
    .str ((s.drop 1).dropEnd 1).copy
  else .str s

/-- Total stub. Polynomial rolling hash, type `UInt64`. -/
def hash (s : String) : UInt64 :=
  s.foldl (fun acc c => acc * 31 + c.val.toUInt64) 0

def decodeToolCall (j : Json) : Option ToolCall :=
  match j.lookup "name" with
  | some (.str n) => some { name := n, args := (j.lookup "args").getD .null }
  | _             => none

end Myagent
