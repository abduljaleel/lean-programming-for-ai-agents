-- Book listing around line 9554 (Ch17_SpecifiedLoops).

-- Preamble: earlier listings from this chapter this file needs.
-- Not part of the printed listing.

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

def Workflow.nodeIds (w : Workflow) : List NodeId :=
  w.nodes.map (·.id)

def Workflow.hasNode (w : Workflow) (id : NodeId) : Bool :=
  w.nodeIds.contains id

def Workflow.writtenBefore (w : Workflow) : List String :=
  -- pedagogical: union of all writes. A real checker walks reachability.
  w.nodes.flatMap (·.writes)

def structuralOk (w : Workflow) : Bool :=
  w.hasNode w.start && w.hasNode w.finish &&
    w.edges.all (fun e => w.hasNode e.src && w.hasNode e.dst) &&
    w.nodes.all (fun n =>
      n.reads.all (fun r => w.writtenBefore.contains r || n.writes.contains r)) &&
    w.nodes.all (fun n =>
      match n.tool? with
      | none => n.kind != .step
      | some _ => n.kind == .step)

def succs (w : Workflow) (id : NodeId) : List NodeId :=
  w.edges.filterMap (fun e => if e.src == id then some e.dst else none)

partial def reachable (w : Workflow) (from_ : NodeId) : List NodeId :=
  let rec go (seen : List NodeId) (frontier : List NodeId) : List NodeId :=
    match frontier with
    | [] => seen
    | n :: ns =>
        if seen.contains n then go seen ns
        else go (n :: seen) (succs w n ++ ns)
  go [] [from_]

def finishReachable (w : Workflow) : Bool :=
  (reachable w w.start).contains w.finish

-- Printed listing.

def nid (s : String) : NodeId := ⟨s⟩

def sweLoop : Workflow where
  nodes := [
    { id := nid "explore",   kind := .step, reads := [],
      writes := ["repoMap", "bugReport"], tool? := some "list_dir" },
    { id := nid "reproduce", kind := .step, reads := ["bugReport"],
      writes := ["reproScript", "failingTest"], tool? := some "run_tests" },
    { id := nid "fix",       kind := .step, reads := ["failingTest", "repoMap"],
      writes := ["diff"], tool? := some "edit_file" },
    { id := nid "verify",    kind := .step, reads := ["diff", "failingTest"],
      writes := ["testLog", "verifyOk"], tool? := some "run_tests" },
    { id := nid "patch",     kind := .step, reads := ["diff", "verifyOk"],
      writes := ["prUrl"], tool? := some "open_pr" }
  ]
  edges := [
    ⟨nid "explore", nid "reproduce"⟩,
    ⟨nid "reproduce", nid "fix"⟩,
    ⟨nid "fix", nid "verify"⟩,
    ⟨nid "verify", nid "patch"⟩,
    ⟨nid "verify", nid "fix"⟩          -- retry
  ]
  start := nid "explore"
  finish := nid "patch"
