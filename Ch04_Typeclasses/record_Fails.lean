-- Book listing around line 1897 (Ch04_Typeclasses).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def record (c : ToolCall) (r : ToolResult Json) : AgentM Unit := do
--   modify (fun t => .step c r t)
--
-- def recordE (c : ToolCall) (r : ToolResult Json) : AgentEM Unit := do
--   record c r   -- lifted through ExceptT
