-- Book listing around line 4974 (Ch09_MetaprogrammingII).
import Lean

open Lean Meta Elab Tactic Term

elab "suppose " n:ident " : " t:term : tactic => do
  let n : Name := n.getId
  let mvarId ← getMainGoal
  mvarId.withContext do
    let t ← elabType t
    let p ← mkFreshExprMVar t MetavarKind.syntheticOpaque n
    let (_, mvarIdNew) ← MVarId.intro1P (← mvarId.assert n t p)
    replaceMainGoal [p.mvarId!, mvarIdNew]
  evalTactic (← `(tactic| rotate_left))
