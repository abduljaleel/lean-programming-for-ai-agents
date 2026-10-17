-- Book listing around line 538 (Ch02_TypesTermsKernel).
structure NonemptyString where
  value : String
  ok    : value ≠ ""

def username : NonemptyString :=
  { value := "ak", ok := by decide }
