-- Book listing around line 4448 (Ch08_MetaprogrammingI).
import Lean

open Lean Elab Term

syntax:max "ok?" term:max : term

elab_rules : term
  | `(ok? $r:term) => do
      let r ← elabTerm r none
      -- produce the syntax for `ToolResult.isOk r = true` and elaborate that
      let stx ← `(ToolResult.isOk $(← Term.exprToSyntax r) = true)
      elabTerm stx (some (mkConst ``Bool))
