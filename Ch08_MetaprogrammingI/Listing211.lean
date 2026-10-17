-- Book listing around line 4479 (Ch08_MetaprogrammingI).
import Lean

open Lean Elab Command Term

elab "#assertType " t:term " : " ty:term : command => do
  let t ← liftTermElabM do
    let expected ← elabType ty
    let e ← elabTermEnsuringType t expected
    synthesizeSyntheticMVarsNoPostponing
    return e
  logInfo m!"ok: {t} : {ty}"
