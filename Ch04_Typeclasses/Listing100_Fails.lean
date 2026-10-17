-- Book listing around line 2010 (Ch04_Typeclasses).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- #synth Capable .readFile
-- #synth Capable .listDir
-- #synth Monad (StateT Trace IO)
-- #synth MonadLiftT IO (StateT Trace IO)
-- #synth Log (ExceptT String (StateT Trace IO))
