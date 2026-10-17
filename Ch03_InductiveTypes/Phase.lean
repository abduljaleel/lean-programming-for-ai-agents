-- Book listing around line 1041 (Ch03_InductiveTypes).
inductive Phase where
  | needAuth
  | authed
  | spent
deriving Repr, BEq

inductive Session : Phase → Type where
  | anon   : Session .needAuth
  | login  : String → Session .needAuth → Session .authed
  | charge : Nat → Session .authed → Session .spent

def Session.user? : {p : Phase} → Session p → Option String
  | _, .anon      => none
  | _, .login u _ => some u
  | _, .charge _ s => s.user?
