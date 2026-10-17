-- Book listing around line 1460 (Ch03_InductiveTypes).
inductive Tree (α : Type) where
  | leaf (val : α)
  | node (children : List (Tree α))
deriving Repr

def Tree.size {α : Type} : Tree α → Nat
  | .leaf _  => 1
  | .node cs => 1 + (cs.map Tree.size).foldl (· + ·) 0
