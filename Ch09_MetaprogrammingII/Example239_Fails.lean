-- Book listing around line 5020 (Ch09_MetaprogrammingII).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example (a : Nat) : 0 + a = a := by
--   suppose add_comm : 0 + a = a + 1
--   -- the supposed fact is false; the *original* goal may still close
--   -- if you rewrite with something else. The leftover goal will not.
--   rw [Nat.zero_add]
--   -- ⊢ 0 + a = a + 1  remains
