-- Book listing around line 10318 (Ch18_WorkedAgent).
-- Myagent/Tools.lean
import Myagent.Spec
namespace Myagent

def underWorkspace (path : String) : Bool :=
  path.startsWith "/workspace/" && !(path.contains "..")

def checkReadFilePre (c : ToolCall) : Bool :=
  c.name == "read_file" &&
    match c.args.lookup "path" with
    | some (.str p) => underWorkspace p
    | _             => false

def readFilePre (c : ToolCall) : Prop :=
  c.name = "read_file" ∧
    ∃ p, c.args.lookup "path" = some (.str p) ∧ underWorkspace p = true

theorem checkReadFilePre_sound (c : ToolCall)
    (h : checkReadFilePre c = true) : readFilePre c := by
  unfold checkReadFilePre at h
  cases hb : (c.name == "read_file") <;> simp [hb] at h
  constructor
  · exact beq_iff_eq.mp hb
  · split at h
    · next p hp => exact ⟨p, hp, h⟩
    · contradiction

def readFileContract : Contract Json where
  pre  := readFilePre
  run  := fun c _ => do
    match c.args.lookup "path" with
    | some (.str p) =>
        try
          let s ← IO.FS.readFile p
          pure (.ok (.str s))
        catch e =>
          pure (.failed (toString e))
    | _ => pure (.denied "missing path")
  post := fun _ r =>
    match r with
    | .ok s     => match s with | .str t => t ≠ "" | _ => False
    | .denied m => m ≠ ""
    | .failed _ => False

instance : Capable "read_file" where
  contract := readFileContract
  checkPre := checkReadFilePre
  checkPre_correct := by
    intro c _ ht
    exact checkReadFilePre_sound c ht

-- The SWE tools from Chapter 17, computational side only.

def checkListDirPre (c : ToolCall) : Bool :=
  c.name == "list_dir" &&
    match c.args.lookup "path" with
    | some (.str p) => underWorkspace p
    | _             => false

def checkRunTestsPre (c : ToolCall) : Bool :=
  c.name == "run_tests" &&
    match c.args.lookup "suite" with
    | some (.str s) => s.startsWith "tests/"
    | _             => false

def checkEditFilePre (c : ToolCall) : Bool :=
  c.name == "edit_file" &&
    match c.args.lookup "path" with
    | some (.str p) => underWorkspace p
    | _             => false

def checkOpenPrPre (c : ToolCall) : Bool :=
  c.name == "open_pr" &&
    match c.args.lookup "title" with
    | some (.str t) => t ≠ ""
    | _             => false

def checkCall (c : ToolCall) : Verdict :=
  if c.name == "read_file" then
    if checkReadFilePre c then .accept else .reject "read_file pre"
  else if c.name == "list_dir" then
    if checkListDirPre c then .accept else .reject "list_dir pre"
  else if c.name == "run_tests" then
    if checkRunTestsPre c then .accept else .reject "run_tests pre"
  else if c.name == "edit_file" then
    if checkEditFilePre c then .accept else .reject "edit_file pre"
  else if c.name == "open_pr" then
    if checkOpenPrPre c then .accept else .reject "open_pr pre"
  else
    .abstain s!"unknown tool {c.name}"

end Myagent
