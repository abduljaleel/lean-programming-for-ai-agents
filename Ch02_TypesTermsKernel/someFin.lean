-- Book listing around line 477 (Ch02_TypesTermsKernel).
def someFin : (n : Nat) × Fin (n + 1) :=
  ⟨4, ⟨2, by omega⟩⟩
