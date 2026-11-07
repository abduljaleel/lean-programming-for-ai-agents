/- Chapter 20. Soundness error as arithmetic. Errors
    are tracked in bits: an error of 2^-b is "b bits of
    security". Independent repetition adds bits; a union
    bound over many attempts subtracts them. -/
namespace PI.Amplify

/-- Rounds of a protocol with `perRound` bits each,
    needed to reach `target` bits. Ceiling division. -/
def roundsNeeded (perRound target : Nat) : Nat :=
  (target + perRound - 1) / perRound

/-- Enough rounds really are enough. -/
theorem roundsNeeded_spec (perRound target : Nat) (h : 0 < perRound) :
    target ≤ perRound * roundsNeeded perRound target := by
  unfold roundsNeeded
  have := Nat.div_add_mod (target + perRound - 1) perRound
  have := Nat.mod_lt (target + perRound - 1) h
  omega

/-- A union bound: a cheater who may try 2^q times loses
    q bits. -/
def afterAttempts (bits q : Nat) : Nat := bits - q

/-- Security never goes up because an attacker tried
    harder. -/
theorem afterAttempts_le (bits q : Nat) : afterAttempts bits q ≤ bits := by
  unfold afterAttempts; omega

/-- A sumcheck round over a field of size about 2^f, for
    a polynomial of degree d per variable, errs with
    probability at most d / 2^f. With d a small power of
    two, 2^e, that is f - e bits per round. -/
def sumcheckRoundBits (fieldBits degBits : Nat) : Nat := fieldBits - degBits

#eval roundsNeeded 20 128                     -- 7
#eval roundsNeeded 1 128                      -- 128
#eval afterAttempts 128 64                    -- 64
#eval sumcheckRoundBits 64 1                  -- 63

end PI.Amplify
