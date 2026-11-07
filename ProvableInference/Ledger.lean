/- Chapters 23 and 24. Two operational pieces around
    the gate: a per-commitment request budget, and a
    post-hoc audit queue that keeps actions taken before
    a proof arrived separate from checked ones. -/
import ProvableInference.Pipeline
namespace PI.Ledger
open PI.Pipeline

/-- Requests used per commitment, with one budget for
    all. -/
structure Ledger where
  budget : Nat
  used   : List (UInt64 × Nat)

def Ledger.count (L : Ledger) (c : UInt64) : Nat :=
  ((L.used.find? (·.1 == c)).map (·.2)).getD 0

def bump (c : UInt64) : List (UInt64 × Nat) → List (UInt64 × Nat)
  | [] => [(c, 1)]
  | (d, n) :: rest => if d == c then (d, n + 1) :: rest else (d, n) :: bump c rest

/-- Record one request, or refuse once the commitment's
    budget is spent. -/
def Ledger.record (L : Ledger) (c : UInt64) : Option Ledger :=
  if L.count c < L.budget then some { L with used := bump c L.used } else none

/-- Every count is within the budget. -/
def Ledger.Within (L : Ledger) : Prop := ∀ p ∈ L.used, p.2 ≤ L.budget

theorem bump_find (c : UInt64) : ∀ (u : List (UInt64 × Nat)) (p : UInt64 × Nat),
    p ∈ bump c u → p ∈ u ∨ p.2 = ((u.find? (·.1 == c)).map (·.2)).getD 0 + 1
  | [], p, h => by simp [bump] at h; simp [h]
  | (d, n) :: rest, p, h => by
    unfold bump at h
    by_cases hd : d == c
    · simp only [hd, ↓reduceIte, List.mem_cons] at h
      rcases h with h | h
      · right; subst h; simp [List.find?, hd]
      · left; exact List.mem_cons_of_mem _ h
    · simp only [hd, Bool.false_eq_true, ↓reduceIte, List.mem_cons] at h
      rcases h with h | h
      · left; subst h; exact List.mem_cons_self
      · rcases bump_find c rest p h with h' | h'
        · left; exact List.mem_cons_of_mem _ h'
        · right; simp [List.find?, hd, h']

/-- Recording never breaks the budget invariant. -/
theorem record_within (L L' : Ledger) (c : UInt64)
    (hL : L.Within) (h : L.record c = some L') : L'.Within := by
  unfold Ledger.record at h
  split at h
  · rename_i hlt
    cases h
    intro p hp
    rcases bump_find c L.used p hp with h1 | h1
    · exact hL p h1
    · simp only [Ledger.count] at hlt; show p.2 ≤ L.budget; omega
  · cases h

/-- Post-hoc mode: actions may run before their proof is
    checked, but they stay `pending` until a verifier
    settles them. -/
inductive Status where
  | pending
  | settled
  | flagged
  deriving Repr, DecidableEq

structure Entry where
  receipt : Receipt
  status  : Status

def settle (V : Verifier) (e : Entry) : Entry :=
  match e.status with
  | .pending => { e with status := if V e.receipt.stmt e.receipt.proof then .settled else .flagged }
  | _ => e

def audit (V : Verifier) (log : List Entry) : List Entry := log.map (settle V)

/-- After an audit nothing is pending, so every action
    is either backed by an accepted proof or flagged for
    incident response. -/
theorem audit_no_pending (V : Verifier) (log : List Entry) :
    ∀ e ∈ audit V log, e.status ≠ .pending := by
  intro e he
  simp only [audit, List.mem_map] at he
  obtain ⟨e0, -, rfl⟩ := he
  unfold settle
  split
  · split <;> simp
  · rename_i h; simpa using h

/-- A settled entry carries an accepted proof, provided
    it was pending before the audit (entries marked
    settled by hand are not trusted). -/
theorem settled_verified (V : Verifier) (e : Entry) (h0 : e.status = .pending)
    (h : (settle V e).status = .settled) : V e.receipt.stmt e.receipt.proof = true := by
  unfold settle at h
  rw [h0] at h
  simp only at h
  split at h
  · assumption
  · cases h

def acceptAll : Verifier := fun _ _ => true

-- false: third request refused
#eval (({ budget := 2, used := [] } : Ledger).record 7 >>= (·.record 7) >>= (·.record 7)).isSome
-- [flagged]
#eval (audit rejectAll [⟨⟨7, 1, "deploy", []⟩, .pending⟩]).map (·.status)
-- [settled]
#eval (audit acceptAll [⟨⟨7, 1, "deploy", []⟩, .pending⟩]).map (·.status)

end PI.Ledger
