-- Book listing around line 5200 (Ch09_MetaprogrammingII).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- example : True := by
--   check_contract! echoC on { name := "echo", args := { raw := "hi" } } giving "hi"
--   · simp [Contract.pre, echoC, echoPre]
--   · simp [Contract.post, echoC, echoPost]
