-- Book listing around line 5255 (Ch09_MetaprogrammingII).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- elab "close_pre " c:ident : tactic => do
--   evalTactic (← `(tactic| simp [Contract.pre, $c:ident]))
