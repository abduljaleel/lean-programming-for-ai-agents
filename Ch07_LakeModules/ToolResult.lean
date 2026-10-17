-- Book listing around line 3917 (Ch07_LakeModules).
module

public inductive ToolResult (α : Type) where
  | ok     : α → ToolResult α
  | denied : String → ToolResult α
  | failed : String → ToolResult α

public def ToolResult.isOk {α : Type} : ToolResult α → Bool
  | .ok _ => true
  | _     => false

/-- Clients can use the name; they cannot unfold the body. -/
public def Safe {α : Type} (ok : α → Prop) : ToolResult α → Prop
  | .ok v     => ok v
  | .denied _ => False
  | .failed _ => False

@[expose]
public def ToolResult.isOkExposed {α : Type} : ToolResult α → Bool
  | .ok _ => true
  | _     => false
