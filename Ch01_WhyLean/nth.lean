-- Book listing around line 107 (Ch01_WhyLean).
def nth {α : Type} {n : Nat} (xs : Vector α n) (i : Fin n) : α :=
  xs[i]
