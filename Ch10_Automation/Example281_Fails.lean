-- Book listing around line 5756 (Ch10_Automation).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example (n : Nat) (h : n < 3) (p q : Prop) (hpq : p ∧ q) :
--     n ≤ 2 ∧ q := by
--   constructor
--   · grind
--   · aesop
