-- Book listing around line 3315 (Ch06_PropTactics).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- theorem safe_congr {α : Type} (ok : α → Prop) (r s : ToolResult α)
--     (h : r = s) : Safe ok r ↔ Safe ok s := by
--   conv =>
--     lhs
--     rw [h]
