-- Book listing around line 5378 (Ch09_MetaprogrammingII).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- -- Bad: elaborates `call` as whatever, fails in mkAppM with a worse message.
-- -- let callE ← elabTerm call none
--
-- -- Good:
-- let callE ← elabTermEnsuringType call (mkConst ``ToolCall)
