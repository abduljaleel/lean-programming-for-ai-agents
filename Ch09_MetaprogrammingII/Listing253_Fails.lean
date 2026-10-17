-- Book listing around line 5267 (Ch09_MetaprogrammingII).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- elab "rfl_or_simp" : tactic => do
--   if (← observing? (evalTactic (← `(tactic| rfl)))).isSome then
--     return
--   evalTactic (← `(tactic| simp))
