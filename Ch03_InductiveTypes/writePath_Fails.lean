-- Book listing around line 1140 (Ch03_InductiveTypes).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def writePath? : Action → Option String
--   | a@(.write path _) =>
--       -- `a` is the full action if you need it
--       some path
--   | _ => none
