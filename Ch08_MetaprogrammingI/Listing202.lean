-- Book listing around line 4338 (Ch08_MetaprogrammingI).
import Lean
syntax "result!" term : term

macro_rules
  | `(result! ok $v:term)    => `(ToolResult.ok $v)
  | `(result! denied $m:term) => `(ToolResult.denied $m)
  | `(result! failed $m:term) => `(ToolResult.failed $m)
