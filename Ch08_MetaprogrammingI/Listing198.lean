-- Book listing around line 4305 (Ch08_MetaprogrammingI).
import Lean
macro x:ident " ↦ " y:term : term => `(fun $x => $y)
