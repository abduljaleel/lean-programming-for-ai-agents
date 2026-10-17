-- Book listing around line 1794 (Ch04_Typeclasses).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- instance loose : Capable .readFile where
--   run _ := .ok (.readFile "anyone")
--
-- -- no error: the later instance silently wins
-- -- (exact wording varies; the second instance is the bug)
