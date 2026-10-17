-- Book listing around line 2334 (Ch05_DoMonads).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def runStep (goal : String) (c : ToolCall) [Capable ToolCall] :
--     IO (Except String (ToolResult Json) × Trace) :=
--   (stepE goal c).run .empty
