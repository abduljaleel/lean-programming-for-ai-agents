-- Book listing around line 9468 (Ch17_SpecifiedLoops).
inductive NodeKind where
  | task    -- a unit of work the agent must finish
  | step    -- a single tool-backed action
  | while   -- a loop with a decidable guard
  | parallel
deriving Repr, BEq, DecidableEq

structure NodeId where
  name : String
deriving Repr, BEq, DecidableEq, Inhabited

structure Node where
  id    : NodeId
  kind  : NodeKind
  reads : List String
  writes : List String
  tool? : Option String    -- `some n` requires `Capable n`
deriving Repr

structure Edge where
  src : NodeId
  dst : NodeId
deriving Repr, BEq

structure Workflow where
  nodes : List Node
  edges : List Edge
  start : NodeId
  finish : NodeId
deriving Repr
