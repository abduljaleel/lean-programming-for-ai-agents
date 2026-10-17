-- Book listing around line 1077 (Ch03_InductiveTypes).
inductive Expr where
  | var  : Nat → Expr
  | lam  : Expr → Expr
  | app  : Expr → Expr → Expr
deriving Repr
