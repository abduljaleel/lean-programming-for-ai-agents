-- Book listing around line 1087 (Ch03_InductiveTypes).
mutual
inductive Expr' where
  | num  : Int → Expr'
  | call : String → Args → Expr'
deriving Repr

inductive Args where
  | nil  : Args
  | cons : Expr' → Args → Args
deriving Repr
end
