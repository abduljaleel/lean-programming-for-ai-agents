-- Book listing around line 8040 (Ch14_ProofAgents).
theorem or_comm_term (p q : Prop) : p ∨ q → q ∨ p :=
  fun h =>
    match h with
    | Or.inl hp => Or.inr hp
    | Or.inr hq => Or.inl hq
