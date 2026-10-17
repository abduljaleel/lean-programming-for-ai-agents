-- Book listing around line 4694 (Ch08_MetaprogrammingI).
import Lean
declare_syntax_cat toolResultLit
syntax "ok " term : toolResultLit
syntax "denied " term : toolResultLit
syntax "failed " term : toolResultLit

syntax "trace[" sepBy(term " ↦ " toolResultLit, "; ") "]" : term

macro_rules
  | `(trace[]) => `(Trace.empty)
  | `(trace[ $c:term ↦ ok $v:term ]) =>
      `(Trace.step $c (ToolResult.ok $v) Trace.empty)
  | `(trace[ $c:term ↦ denied $m:term ]) =>
      `(Trace.step $c (ToolResult.denied $m) Trace.empty)
  | `(trace[ $c:term ↦ failed $m:term ]) =>
      `(Trace.step $c (ToolResult.failed $m) Trace.empty)
