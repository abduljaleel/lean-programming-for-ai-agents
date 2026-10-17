-- Book listing around line 1245 (Ch03_InductiveTypes).
inductive DenyReason where
  | sandbox
  | quota
  | auth
deriving Repr, BEq, DecidableEq, Inhabited
