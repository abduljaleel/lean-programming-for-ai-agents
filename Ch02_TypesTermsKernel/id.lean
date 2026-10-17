-- Book listing around line 803 (Ch02_TypesTermsKernel).
-- Explicit. Caller writes it.
def id₁ (α : Type) (x : α) : α := x

-- Implicit. Lean infers it from `x`.
def id₂ {α : Type} (x : α) : α := x

-- Instance-implicit. Lean searches for a typeclass instance.
def id₃ [Inhabited α] : α := default
