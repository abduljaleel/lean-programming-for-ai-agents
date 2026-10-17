-- Book listing around line 10574 (Ch18_WorkedAgent).
-- Main.lean
import Myagent

open Myagent

def usage : String :=
  "checker --call     < json ToolCall on stdin\n" ++
  "checker --replay   < json trajectory on stdin\n" ++
  "checker --self-test"

def runCall : IO UInt32 := do
  let raw ← (← IO.getStdin).readToEnd
  -- parseJson is the total stub in Myagent/Spec.lean
  match decodeToolCall (parseJson raw) with
  | none =>
      IO.eprintln "REJECT decode failed"
      return 2
  | some c =>
      let v := checkCall c
      match v with
      | .accept => IO.println v.toString
      | _       => IO.eprintln v.toString
      return v.toExit

def runSelfTest : IO UInt32 := do
  if selfTest then
    IO.println "ACCEPT self-test"
    return 0
  else
    IO.eprintln "REJECT self-test: failingVerify was not rejected"
    return 1

def main (args : List String) : IO UInt32 := do
  match args with
  | ["--self-test"] => runSelfTest
  | ["--call"]      => runCall
  | ["--replay"]    =>
      IO.eprintln "ABSTAIN replay JSON decoder not wired in this listing"
      return 3
  | _ =>
      IO.eprintln usage
      return 2
