-- Book listing around line 5727 (Ch10_Automation).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example (p q : Prop) (h : p ∧ q) : q ∧ p := by
--   aesop?
--   -- try this: constructor <;> first | exact h.right | exact h.left
--   -- (wording varies by Aesop version; paste what *your* pin prints)
