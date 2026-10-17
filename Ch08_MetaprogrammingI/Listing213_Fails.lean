-- Book listing around line 4506 (Ch08_MetaprogrammingI).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- elab "#assertType " t:term " : " ty:term : command => do
--   liftTermElabM do
--     let expected ← elabType ty
--     let _ ← elabTermEnsuringType t expected
--     synthesizeSyntheticMVarsNoPostponing
--   logInfo "ok"
