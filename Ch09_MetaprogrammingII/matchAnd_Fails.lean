-- Book listing around line 4914 (Ch09_MetaprogrammingII).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def matchAnd (e : Expr) : MetaM (Option (Expr × Expr)) := do
--   match (← whnf e) with
--   | .app (.app (.const ``And _) P) Q => return some (P, Q)
--   | _ => return none
