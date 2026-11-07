import ProvableInference.Relation
import ProvableInference.Merkle
import ProvableInference.Sumcheck
import ProvableInference.FiatShamir
import ProvableInference.Model
import ProvableInference.Pipeline
import ProvableInference.Amplify
import ProvableInference.Lookup
import ProvableInference.Ledger

/-! Axiom audit for every headline theorem in Part V. -/
#print axioms PI.trivial_sound
#print axioms PI.Merkle.open_complete
#print axioms PI.Merkle.binding
#print axioms PI.Sumcheck.complete
#print axioms PI.Sumcheck.lines_meet_once
#print axioms PI.FiatShamir.ni_complete
#print axioms PI.Model.accepted_token_unique
#print axioms PI.Pipeline.admitted_correct
#print axioms PI.Amplify.roundsNeeded_spec
#print axioms PI.Lookup.checkLookup_sound
#print axioms PI.Lookup.clamp_in_range
#print axioms PI.Ledger.record_within
#print axioms PI.Ledger.audit_no_pending
#print axioms PI.Ledger.settled_verified
