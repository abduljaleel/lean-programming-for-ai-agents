/- Chapter 21. Fiat-Shamir: replace the verifier's
    coins with a hash of the transcript so far. The
    verifier recomputes every challenge. -/
import ProvableInference.Sumcheck

namespace PI.FiatShamir
open PI.Sumcheck

/-- A transcript hash. Modelled as an arbitrary
    function: the random oracle model is the assumption
    that it behaves like a fresh random function. Lean
    cannot prove that, and this file does not pretend
    to. -/
abbrev Oracle := List Int → Int

/-- Absorb the statement first (strong Fiat-Shamir),
    then each message. -/
def challenges (H : Oracle) (claim : Int) : List Msg → List Int
  | ms => go [claim] ms
where
  go : List Int → List Msg → List Int
    | _,  []            => []
    | tr, (a, b) :: ms  =>
        let tr' := tr ++ [a, b]
        H tr' :: go (tr' ++ [H tr']) ms

/-- The non-interactive verifier: derive the challenges,
    then run the interactive check. There is nothing for
    the prover to choose. -/
def verifyNI (H : Oracle) (O : List Int → Int) (claim : Int) (ms : List Msg) : Bool :=
  check O claim ms (challenges H claim ms) []

/-- The non-interactive honest prover must produce
    messages and challenges together, because each
    challenge depends on the message before it. -/
def proveNI (H : Oracle) : ML n → Int → List Int → List Msg
  | .split p q, claim, tr =>
      let m : Msg := (p.hsum, q.hsum)
      let tr' := tr ++ [m.1, m.2]
      let r := H tr'
      m :: proveNI H (ML.comb r p q) claim (tr' ++ [r])
  | .const _, _, _ => []

/-- Challenges the honest NI prover used, recomputed. -/
def usedChallenges (H : Oracle) : ML n → List Int → List Int
  | .split p q, tr =>
      let tr' := tr ++ [p.hsum, q.hsum]
      H tr' :: usedChallenges H (ML.comb (H tr') p q) (tr' ++ [H tr'])
  | .const _, _ => []

theorem honest_eq (H : Oracle) : ∀ (p : ML n) (claim : Int) (tr : List Int),
    proveNI H p claim tr = honest p (usedChallenges H p tr) ∧
    challenges.go H tr (proveNI H p claim tr) = usedChallenges H p tr
  | .const _, _, _ => by simp [proveNI, honest, usedChallenges, challenges.go]
  | .split p q, claim, tr => by
      have ih := honest_eq H (ML.comb (H (tr ++ [p.hsum, q.hsum])) p q) claim
        (tr ++ [p.hsum, q.hsum] ++ [H (tr ++ [p.hsum, q.hsum])])
      refine ⟨by simp only [proveNI, honest, usedChallenges, ih.1], ?_⟩
      simp only [proveNI, challenges.go, usedChallenges]
      rw [ih.2]

theorem usedChallenges_length (H : Oracle) : ∀ (p : ML n) (tr : List Int),
    (usedChallenges H p tr).length = n
  | .const _, _ => rfl
  | .split p q, tr => by simp [usedChallenges, usedChallenges_length]

/-- Completeness survives the transformation, for EVERY
    hash function. -/
theorem ni_complete (H : Oracle) (p : ML n) :
    verifyNI H p.eval p.hsum (proveNI H p p.hsum [p.hsum]) = true := by
  have h := honest_eq H p p.hsum [p.hsum]
  unfold verifyNI challenges
  rw [h.2, h.1]
  exact complete p _ (usedChallenges_length H p _)

/-- A toy oracle, for running examples only. -/
def toyH : Oracle := fun xs => (xs.foldl (fun acc x => acc * 31 + x) 7) % 1000003

-- true
#eval verifyNI toyH f3.eval f3.hsum (proveNI toyH f3 f3.hsum [f3.hsum])
-- false
#eval verifyNI toyH f3.eval 9 (proveNI toyH f3 f3.hsum [f3.hsum])

end PI.FiatShamir
