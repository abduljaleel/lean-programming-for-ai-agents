-- Book listing around line 2120 (Ch05_DoMonads).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def decodeBoth (goalLine callLine : String) : Option (String × ToolCall) := do
--   let g ← decodeGoal goalLine
--   let c ← decodeCall callLine
--   pure (g, c)
