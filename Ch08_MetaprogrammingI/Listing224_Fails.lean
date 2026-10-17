-- Book listing around line 4714 (Ch08_MetaprogrammingI).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- macro_rules
--   | `(trace[ $c:term ↦ ok $v:term ; $rest,* ]) =>
--       `(Trace.step $c (ToolResult.ok $v) trace[ $rest,* ])
