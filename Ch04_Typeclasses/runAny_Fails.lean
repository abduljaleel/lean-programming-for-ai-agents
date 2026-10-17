-- Book listing around line 2022 (Ch04_Typeclasses).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- variable {id : ToolId} [Capable id]
--
-- def runAny (input : ToolInput id) : ToolResult (ToolOutput id) :=
--   Capable.run input
--
-- -- main still cannot call `runAny (id := .listDir)` without an instance.
