-- Book listing around line 1376 (Ch03_InductiveTypes).
inductive ToolId where
  | readFile
  | writeFile
  | listDir
  | finish
deriving Repr, BEq, DecidableEq

inductive ToolInput : ToolId → Type where
  | readFile  : (path : String) → ToolInput .readFile
  | writeFile : (path : String) → (contents : String) → ToolInput .writeFile
  | listDir   : (path : String) → ToolInput .listDir
  | finish    : (summary : String) → ToolInput .finish

inductive ToolOutput : ToolId → Type where
  | readFile  : (body : String) → ToolOutput .readFile
  | writeFile : ToolOutput .writeFile
  | listDir   : (n : Nat) → Vector String n → ToolOutput .listDir
  | finish    : ToolOutput .finish

structure Call (id : ToolId) where
  input : ToolInput id

structure Reply (id : ToolId) where
  output : ToolOutput id
