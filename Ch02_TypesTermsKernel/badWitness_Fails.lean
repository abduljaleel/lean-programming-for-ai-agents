-- Book listing around line 778 (Ch02_TypesTermsKernel).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- -- This will not give you a Nat at runtime.
-- -- `∃` is in Prop; the witness is erased.
-- def badWitness (h : ∃ n : Nat, n > 10) : Nat :=
--   -- no legal extraction
--   0
