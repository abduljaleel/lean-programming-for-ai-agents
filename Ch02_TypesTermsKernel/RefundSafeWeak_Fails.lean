-- Book listing around line 855 (Ch02_TypesTermsKernel).
-- Quoted as comments because it is not a standalone Lake module
-- (depends on surrounding text, is a sketch, or does not elaborate on its own).

-- def RefundSafeWeak (c : Charge) (r : Refund) : Prop :=
--   r.amount ≤ c.amount   -- dropped the id check
--
-- theorem sample_safe_drifted : RefundSafeWeak sampleCharge sampleRefund := by
--   simp [RefundSafeWeak, sampleCharge, sampleRefund]
--   omega
