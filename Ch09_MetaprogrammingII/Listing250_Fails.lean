-- Book listing around line 5229 (Ch09_MetaprogrammingII).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- elab "silent_ok " t:term : tactic => do
--   let _ ← elabTerm t none
--   -- forgot synthesizeSyntheticMVarsNoPostponing
--   -- a missing instance becomes a leftover synthetic mvar
--   -- the tactic "succeeds"; the file fails later, or worse, a default instance fills it
