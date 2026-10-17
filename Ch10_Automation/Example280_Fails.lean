-- Book listing around line 5747 (Ch10_Automation).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example (p q : Prop) (h : p ∧ q) : q ∧ p := by
--   aesop (add safe And.left) (add safe And.right)
