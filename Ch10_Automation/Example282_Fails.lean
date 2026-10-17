-- Book listing around line 5778 (Ch10_Automation).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example (n : Nat) : 0 + n = n := by
--   simp
--
-- example {α : Type} (ok : α → Prop) (v : α) :
--     Safe ok (.ok v) ↔ ok v := by
--   simp [Safe]
