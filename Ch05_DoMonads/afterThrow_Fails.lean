-- Book listing around line 2637 (Ch05_DoMonads).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def afterThrow (c : ToolCall) : AgentEM Unit := do
--   throw "no"
--   record c (.failed "no")   -- unreachable; warning, not error
