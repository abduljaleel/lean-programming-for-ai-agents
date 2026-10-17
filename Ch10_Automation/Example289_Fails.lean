-- Book listing around line 5873 (Ch10_Automation).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example (n : Nat) : ⦃⌜True⌝⦄ inc15 n ⦃⇓ r => ⌜r = n + 15⌝⦄ := by
--   mvcgen' [inc15, increaseBy] until increaseBy _ 4
--   case vc1 a =>
--     mvcgen'    -- resume the rest
--     grind
