-- Book listing around line 947 (Ch03_InductiveTypes).

-- Preamble: earlier listings from this chapter this file needs.
-- Not part of the printed listing.

inductive Action where
  | read   (path : String)
  | write  (path : String) (contents : String)
  | shell  (cmd : String)
  | finish (summary : String)
deriving Repr, Inhabited, BEq

-- Printed listing.

def step : Action := .read "src/Main.lean"
def done : Action := Action.finish "patched the timeout"
