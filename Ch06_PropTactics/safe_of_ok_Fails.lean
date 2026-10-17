-- Book listing around line 3067 (Ch06_PropTactics).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- theorem safe_of_ok (s : String) (h : nonempty s) :
--     Safe nonempty (.ok s) := by
--   intro
--   -- wait: Safe nonempty (.ok s) is definitionally `nonempty s`
--   exact h
