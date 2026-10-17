-- Book listing around line 2528 (Ch05_DoMonads).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def retForward : IO Nat := do
--   let mut x := 0
--   withLogging (do←
--     x := 1
--     return x)          -- leaves retForward, value 1
--   return 99            -- not reached
