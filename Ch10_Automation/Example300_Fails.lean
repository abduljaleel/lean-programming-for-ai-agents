-- Book listing around line 6050 (Ch10_Automation).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example {α : Type} (ok : α → Prop) (v : α) (h : Safe ok (.ok v)) :
--     ok v := by
--   simpa [Safe] using h
