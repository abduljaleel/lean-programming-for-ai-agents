-- Book listing around line 3128 (Ch06_PropTactics).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- theorem safe_ok_payload (s : String) (h : Safe nonempty (.ok s)) :
--     s ≠ "" := by
--   have : nonempty s := h
--   exact this
