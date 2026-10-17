-- Book listing around line 1960 (Ch04_Typeclasses).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def sandboxed? (path : String) : Option (Sandboxed path) :=
--   if h : path.startsWith "workspace/" = true then
--     some ⟨h⟩
--   else
--     none
