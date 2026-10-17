-- Book listing around line 4323 (Ch08_MetaprogrammingI).
import Lean
macro x:ident " |-> " y:term : term => `(fun $x => $y)
