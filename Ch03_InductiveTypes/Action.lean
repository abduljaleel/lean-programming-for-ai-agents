-- Book listing around line 932 (Ch03_InductiveTypes).
inductive Action where
  | read   (path : String)
  | write  (path : String) (contents : String)
  | shell  (cmd : String)
  | finish (summary : String)
deriving Repr, Inhabited, BEq
