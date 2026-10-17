-- Book listing around line 4879 (Ch09_MetaprogrammingII).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def someTactic (mvarId : MVarId) : MetaM Unit :=
--   mvarId.withContext do
--     let tgt ← mvarId.getType
--     -- fvars in tgt now resolve
--     pure ()
