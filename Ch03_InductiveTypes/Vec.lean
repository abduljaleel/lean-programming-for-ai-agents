-- Book listing around line 1022 (Ch03_InductiveTypes).
inductive Vec (α : Type) : Nat → Type where
  | nil  : Vec α 0
  | cons : α → Vec α n → Vec α (n + 1)
