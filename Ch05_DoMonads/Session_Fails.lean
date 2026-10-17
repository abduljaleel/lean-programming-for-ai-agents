-- Book listing around line 2592 (Ch05_DoMonads).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def Session.user?' [Monad m] {p : Phase} (s : Session p) : m (Option String) := do
--   match (dependent := true) s with
--   | .anon      => pure none
--   | .login u _ => pure (some u)
