-- Book listing around line 464 (Ch02_TypesTermsKernel).
def Repeat (α : Type) : Nat → Type
  | 0     => Unit
  | n + 1 => α × Repeat α n

def twoNats : Repeat Nat 2 :=
  (1, (2, ()))
