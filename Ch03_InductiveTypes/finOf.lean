-- Book listing around line 1405 (Ch03_InductiveTypes).
def finOf? (n i : Nat) : Option (Fin n) :=
  if h : i < n then some ⟨i, h⟩ else none
