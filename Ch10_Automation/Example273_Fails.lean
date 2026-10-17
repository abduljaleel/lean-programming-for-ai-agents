-- Book listing around line 5624 (Ch10_Automation).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example (x y : Int) (h : 2 * x + 3 * y = 0) : True := by
--   grind -lia    -- disable LIA; useful when you want to see what else grind does
--   trivial
--
-- -- grind +qlia              -- accept rational models; incomplete for integers
-- -- grind (liaSteps := 1000) -- cap; becomes incomplete at the cap
