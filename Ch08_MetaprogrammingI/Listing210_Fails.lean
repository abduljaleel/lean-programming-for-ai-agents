-- Book listing around line 4465 (Ch08_MetaprogrammingI).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- elab_rules : term
--   | `(ok? $r:term) => do
--       elabTerm (← `(ToolResult.isOk $r = true)) none
