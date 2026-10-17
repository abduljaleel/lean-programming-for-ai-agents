-- Book listing around line 3520 (Ch06_PropTactics).
example (a b c : Nat) (h1 : a = b) (h2 : b = c) : a = c := by
  grind
