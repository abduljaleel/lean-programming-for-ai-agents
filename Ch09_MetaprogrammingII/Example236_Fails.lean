-- Book listing around line 4954 (Ch09_MetaprogrammingII).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example : 0 + a = a := by
--   suppose add_comm : 0 + a = a + 0
--   rw [add_comm]; rfl          -- closes the original goal
--   rw [Nat.zero_add]; rfl      -- proves add_comm
