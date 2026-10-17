-- Book listing around line 1152 (Ch03_InductiveTypes).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def Vec.last {α : Type} {n : Nat} (xs : Vec α (n + 1)) : α :=
--   match n, xs with
--   | 0, .cons x .nil => x
--   | k + 1, .cons _ xs => Vec.last (n := k) xs
