-- Book listing around line 7139 (Ch12_PythonFFI).
inductive ToolResult (α : Type) where
  | ok     : α → ToolResult α
  | denied : String → ToolResult α
  | failed : String → ToolResult α
