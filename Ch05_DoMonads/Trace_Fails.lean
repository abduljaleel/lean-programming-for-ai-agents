-- Book listing around line 2271 (Ch05_DoMonads).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def Trace.length : Trace → Nat
--   | .empty      => 0
--   | .step _ _ t => 1 + t.length
