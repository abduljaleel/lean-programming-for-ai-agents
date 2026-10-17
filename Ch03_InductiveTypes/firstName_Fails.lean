-- Book listing around line 1445 (Ch03_InductiveTypes).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def firstName? (page : (n : Nat) × Vector String n) : Option String :=
--   match page with
--   | ⟨0, _⟩ => none
--   | ⟨n + 1, v⟩ => some v[⟨0, by omega⟩]
