# Part V. Provable Inference (chapters 19 to 24)

Toy Lean models of the argument systems used to prove which committed model produced a reply. The listings follow the FlashProve setting: a provider commits to weights, then proves that a prompt's output is that model's greedy completion, without handing over the weights.

This folder is one Lake library, `ProvableInference`, because later chapters import earlier ones. `lake build` type-checks every module here. `ProvableInference.lean` at the package root reprints the axioms of every headline theorem.

There are no `*_Fails.lean` files in Part V.

| Ch | Title | Live modules |
|---|---|---|
| 19 | Provable inference: which model answered | `../ProvableInference.lean` (axiom audit for the Part V theorems) |
| 20 | Relations, verifiers, and the three properties | `Relation.lean`, `Amplify.lean` |
| 21 | Merkle openings, sumcheck, and Fiat-Shamir | `Merkle.lean`, `Sumcheck.lean`, `FiatShamir.lean` |
| 22 | A toy MoE layer, traces, and lookups | `Model.lean`, `Lookup.lean` |
| 23 | An agent pipeline that refuses unproved output | `Pipeline.lean` |
| 24 | Request budgets and post-hoc audit | `Ledger.lean` |

`Model.lean` is also used in Chapter 20, where uniqueness of greedy decoding is stated. `Ledger.lean` continues the pipeline from Chapter 23 with a per-commitment budget and an audit queue.

Headline theorems, all proved without extra axioms beyond Lean's kernel:

- `PI.trivial_sound`
- `PI.Merkle.open_complete`, `PI.Merkle.binding`
- `PI.Sumcheck.complete`, `PI.Sumcheck.lines_meet_once`
- `PI.FiatShamir.ni_complete`
- `PI.Model.accepted_token_unique`
- `PI.Pipeline.admitted_correct`
- `PI.Amplify.roundsNeeded_spec`
- `PI.Lookup.checkLookup_sound`, `PI.Lookup.clamp_in_range`
- `PI.Ledger.record_within`, `PI.Ledger.audit_no_pending`, `PI.Ledger.settled_verified`
