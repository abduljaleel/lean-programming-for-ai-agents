-- Book listing around line 4403 (Ch08_MetaprogrammingI).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- contract echoC : String where
-- pre  (c ↦ c.name = "echo")
-- run  (fun c _h => pure (ToolResult.ok (c.args.raw)))
-- post (fun _c r => Safe (s ↦ s ≠ "") r)
