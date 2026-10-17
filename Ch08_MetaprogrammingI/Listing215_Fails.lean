-- Book listing around line 4539 (Ch08_MetaprogrammingI).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- macro "idof " x:ident : term => `(fun $x => $x)
-- #check idof n
-- -- fun n => n
