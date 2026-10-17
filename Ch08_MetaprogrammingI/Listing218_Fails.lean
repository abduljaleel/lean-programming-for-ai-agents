-- Book listing around line 4570 (Ch08_MetaprogrammingI).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- elab "#assertPost " t:term : command => do
--   liftTermElabM do
--     let ty ← elabType (← `(ToolCall → ToolResult String → Prop))
--     let _ ← elabTermEnsuringType t ty
--     synthesizeSyntheticMVarsNoPostponing
--   logInfo "post ok"
