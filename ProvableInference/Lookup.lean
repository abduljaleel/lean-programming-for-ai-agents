/- Chapter 22. Lookups and integer quantization, as
    checks a verifier could run. A nonlinear function
    becomes a table; the prover shows each (input,
    output) pair of the trace is a row of the table. -/
namespace PI.Lookup

/-- A table of allowed (input, output) pairs. -/
abbrev Table := List (Int × Int)

/-- The integer ReLU table on inputs from -r to r. -/
def reluTable (r : Nat) : Table :=
  (List.range (2 * r + 1)).map fun (i : Nat) =>
    let x : Int := (i : Int) - r
    (x, max x 0)

/-- The naive lookup check: every pair is in the table.
    A real lookup argument proves the same statement
    without reading the trace. -/
def checkLookup (T : Table) (trace : List (Int × Int)) : Bool :=
  trace.all fun p => decide (p ∈ T)

theorem checkLookup_sound (T : Table) (trace : List (Int × Int))
    (h : checkLookup T trace = true) : ∀ p ∈ trace, p ∈ T := by
  intro p hp
  unfold checkLookup at h
  have := List.all_eq_true.mp h p hp
  simpa using this

theorem checkLookup_complete (T : Table) (trace : List (Int × Int))
    (h : ∀ p ∈ trace, p ∈ T) : checkLookup T trace = true := by
  unfold checkLookup
  exact List.all_eq_true.mpr (fun p hp => by simpa using h p hp)

/-- Quantize: scale by 2^s and round toward negative
    infinity. Integer division is exact and reproducible
    on every machine. -/
def requant (s : Nat) (x : Int) : Int := x / (2 ^ s : Int)

/-- Clamp into the signed range (-half, half). -/
def clamp (half x : Int) : Int := max (-half + 1) (min x (half - 1))

theorem clamp_in_range (half x : Int) (h : 0 < half) :
    -half < clamp half x ∧ clamp half x < half := by
  unfold clamp
  constructor <;> omega

-- [(-2,0),(-1,0),(0,0),(1,1),(2,2)]
#eval reluTable 2
-- true
#eval checkLookup (reluTable 4) [(3, 3), (-2, 0)]
-- false: not ReLU
#eval checkLookup (reluTable 4) [(3, 3), (-2, -2)]
-- false: outside the table
#eval checkLookup (reluTable 4) [(9, 9)]
#eval requant 4 1000                                -- 62
#eval clamp 128 300                                 -- 127

end PI.Lookup
