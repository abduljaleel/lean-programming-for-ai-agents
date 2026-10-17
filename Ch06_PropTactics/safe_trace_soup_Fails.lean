-- Book listing around line 3593 (Ch06_PropTactics).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- theorem safe_trace_soup (ok : String → Prop) (t : Trace) :
--     t.safe ok → t.denied = false := by
--   induction t <;> simp [Trace.safe, Trace.denied, Safe, *] <;> grind
