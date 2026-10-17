-- Book listing around line 1163 (Ch03_InductiveTypes).
def search (fuel : Nat) (step : σ → Option σ) (s : σ) : Option σ :=
  match fuel with
  | 0 => none
  | f + 1 =>
      match step s with
      | none    => some s
      | some s' => search f step s'
