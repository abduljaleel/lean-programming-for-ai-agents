-- Book listing around line 1259 (Ch03_InductiveTypes).
inductive JValue where
  | null
  | bool : Bool → JValue
  | num  : Int → JValue
  | str  : String → JValue
  | arr  : List JValue → JValue
  | obj  : List (String × JValue) → JValue
deriving Repr, BEq, Inhabited

def JValue.get? (j : JValue) (k : String) : Option JValue :=
  match j with
  | .obj kvs => kvs.lookup k
  | _        => none

def JValue.asStr? : JValue → Option String
  | .str s => some s
  | _      => none

def JValue.asObj? : JValue → Option (List (String × JValue))
  | .obj kvs => some kvs
  | _        => none
