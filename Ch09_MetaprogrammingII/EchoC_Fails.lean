-- Book listing around line 5416 (Ch09_MetaprogrammingII).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def EchoC := Contract String
-- -- check_contract (sorry : EchoC)  will not see `Contract` until whnf
-- abbrev EchoC' := Contract String
-- -- this one will
