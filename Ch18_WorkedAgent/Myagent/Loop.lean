-- Book listing around line 10420 (Ch18_WorkedAgent).
-- Myagent/Loop.lean
import Myagent.Spec
import Myagent.Tools
namespace Myagent

structure NodeId where
  name : String
deriving Repr, BEq, DecidableEq, Inhabited

inductive NodeKind where
  | task | step | while | parallel
deriving Repr, BEq

structure Node where
  id     : NodeId
  kind   : NodeKind
  reads  : List String
  writes : List String
  tool?  : Option String
deriving Repr

structure Edge where
  src : NodeId
  dst : NodeId
deriving Repr, BEq

structure Workflow where
  nodes  : List Node
  edges  : List Edge
  start  : NodeId
  finish : NodeId
deriving Repr

abbrev Store := List (String × Json)

def Store.get (s : Store) (k : String) : Option Json := s.lookup k
def Store.put (s : Store) (k : String) (v : Json) : Store :=
  (k, v) :: s.filter (fun ⟨k', _⟩ => k' != k)

def isNonEmptyString : Json → Bool
  | .str s => s ≠ ""
  | _      => false

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
    ⟨nid "verify", nid "fix"⟩
  ]
  start := nid "explore"
  finish := nid "patch"

def checkNodePre (n : Node) (s : Store) : Bool :=
  match n.id.name with
  | "explore"   => true
  | "reproduce" => isNonEmptyString (s.get "bugReport" |>.getD .null)
  | "fix"       => isNonEmptyString (s.get "failingTest" |>.getD .null)
  | "verify"    => isNonEmptyString (s.get "diff" |>.getD .null)
  | "patch"     => s.get "verifyOk" == some (.bool true)
                    && isNonEmptyString (s.get "diff" |>.getD .null)
  | _           => false

def checkNodePost (n : Node) (r : ToolResult Json) (s' : Store) : Bool :=
  match n.id.name with
  | "verify" =>
      match r with
      | .ok _ =>
          s'.get "verifyOk" == some (.bool true) &&
            match s'.get "testLog" with
            | some (.str log) => !(log.contains "FAILED")
            | _ => false
      | _ => false
  | "patch" => match r with | .ok (.str u) => u.startsWith "https://" | _ => false
  | "explore" => isNonEmptyString (s'.get "bugReport" |>.getD .null)
  | "reproduce" => isNonEmptyString (s'.get "failingTest" |>.getD .null)
  | "fix" => isNonEmptyString (s'.get "diff" |>.getD .null)
  | _ => false

structure StepRecord where
  node     : NodeId
  call     : ToolCall
  result   : ToolResult Json
  storeIn  : Store
  storeOut : Store
deriving Repr

def applyWrites (n : Node) (r : ToolResult Json) (s : Store) : Store :=
  match n.id.name, r with
  | "explore",   .ok v =>
      (s.put "repoMap" v).put "bugReport" (v.lookup "bug" |>.getD (.str "bug"))
  | "reproduce", .ok v =>
      (s.put "reproScript" v).put "failingTest" (v.lookup "test" |>.getD (.str "t"))
  | "fix",       .ok v => s.put "diff" v
  | "verify",    .ok v =>
      let log := (v.lookup "log").getD v
      let ok := match log with | .str s => !(s.contains "FAILED") | _ => false
      (s.put "testLog" log).put "verifyOk" (.bool ok)
  | "patch",     .ok v => s.put "prUrl" v
  | _, _ => s

def replayStep (w : Workflow) (rec : StepRecord) : Bool :=
  match w.nodes.find? (·.id == rec.node) with
  | none => false
  | some n =>
      checkNodePre n rec.storeIn &&
        rec.storeOut == applyWrites n rec.result rec.storeIn &&
        checkNodePost n rec.result rec.storeOut

def replay (w : Workflow) (tr : List StepRecord) : Bool :=
  tr.all (replayStep w)

/-- The Chapter 17 counterexample, as a self-test the exe can run. -/
def failingVerify : StepRecord where
  node := nid "verify"
  call := { name := "run_tests", args := .obj [("suite", .str "tests/")] }
  result := .ok (.obj [("log", .str "tests/test_bill.py::test_refund FAILED")])
  storeIn := [("diff", .str "--- a/bill.py")]
  storeOut := [
    ("diff", .str "--- a/bill.py"),
    ("testLog", .str "tests/test_bill.py::test_refund FAILED"),
    ("verifyOk", .bool true)
  ]

def selfTest : Bool :=
  replayStep sweLoop failingVerify == false

theorem selfTest_ok : selfTest = true := by decide

end Myagent
