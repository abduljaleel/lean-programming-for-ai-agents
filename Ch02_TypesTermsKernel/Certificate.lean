-- Book listing around line 669 (Ch02_TypesTermsKernel).
-- Certificate.lean
-- A one-file certificate an agent must be able to emit, and CI must be
-- able to reject when it is fake.

structure Charge where
  id     : String
  amount : Nat
deriving Repr, BEq

structure Refund where
  chargeId : String
  amount   : Nat
deriving Repr, BEq

def RefundSafe (c : Charge) (r : Refund) : Prop :=
  r.chargeId = c.id ∧ r.amount ≤ c.amount

def sampleCharge : Charge := { id := "ch_1", amount := 100 }
def sampleRefund : Refund := { chargeId := "ch_1", amount := 40 }

-- Real proof. Definitional on the id, linear arithmetic on the amount.
theorem sample_safe : RefundSafe sampleCharge sampleRefund := by
  constructor
  · rfl
  · decide

#print axioms sample_safe
-- 'sample_safe' does not depend on any axioms

#check sample_safe
-- sample_safe : RefundSafe sampleCharge sampleRefund
