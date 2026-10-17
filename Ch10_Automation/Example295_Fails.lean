-- Book listing around line 5969 (Ch10_Automation).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example (n : Nat) : ⦃⌜True⌝⦄ inc n ⦃⇓ r => ⌜r = n + 6⌝⦄ := by
--   mvcgen' [inc]
--   mleave
--   grind
