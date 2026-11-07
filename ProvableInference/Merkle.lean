/- Chapter 21. Hash-based commitments: a Merkle tree
    you can open. The hash is a parameter. The security
    of a real hash (BLAKE2 in FlashProve) is an
    assumption you write down, not a theorem you prove. -/
namespace PI.Merkle

/-- A hash function on 64-bit words, left abstract. -/
abbrev Hash := UInt64 → UInt64 → UInt64

/-- A toy mixer, for running examples only. Not
    collision resistant. -/
def toyHash : Hash := fun a b => (a * (0x9E3779B97F4A7C15 : UInt64)) ^^^ (b + (0x632BE59BD9B4E019 : UInt64)) ^^^ (a >>> 7)

inductive Tree where
  | leaf : UInt64 → Tree
  | node : Tree → Tree → Tree
  deriving Repr

def root (H : Hash) : Tree → UInt64
  | .leaf v   => v
  | .node l r => H (root H l) (root H r)

/-- One step of an authentication path: which side we
    came from, and the sibling digest. -/
inductive Dir where | left | right
  deriving Repr, DecidableEq

abbrev Path := List (Dir × UInt64)

/-- Recompute a root from a leaf value and a path (leaf
    to root). -/
def climb (H : Hash) (v : UInt64) : Path → UInt64
  | []                  => v
  | (.left,  s) :: rest => climb H (H v s) rest
  | (.right, s) :: rest => climb H (H s v) rest

/-- The verifier: accept an opening if it climbs to the
    committed root. -/
def verifyOpening (H : Hash) (c v : UInt64) (p : Path) : Bool :=
  climb H v p == c

/-- Addresses are lists of directions from the root. -/
def openAt (H : Hash) : Tree → List Dir → Option (UInt64 × Path)
  | .leaf v, []            => some (v, [])
  | .node l r, .left :: a  =>
      (openAt H l a).map fun (v, p) => (v, p ++ [(.left, root H r)])
  | .node l r, .right :: a =>
      (openAt H r a).map fun (v, p) => (v, p ++ [(.right, root H l)])
  | _, _                   => none

theorem climb_append (H : Hash) (v : UInt64) (p q : Path) :
    climb H v (p ++ q) = climb H (climb H v p) q := by
  induction p generalizing v with
  | nil => rfl
  | cons hd tl ih =>
    obtain ⟨d, s⟩ := hd
    cases d <;> simp [climb, ih]

/-- Completeness of openings: every honest opening
    climbs to the root. Holds for ANY hash function,
    collision resistant or not. -/
theorem open_complete (H : Hash) :
    ∀ (t : Tree) (a : List Dir) (v : UInt64) (p : Path),
      openAt H t a = some (v, p) → climb H v p = root H t := by
  intro t
  induction t with
  | leaf x =>
    intro a v p h
    cases a with
    | nil => simp [openAt] at h; obtain ⟨rfl, rfl⟩ := h; rfl
    | cons d a => cases d <;> simp [openAt] at h
  | node l r ihl ihr =>
    intro a v p h
    cases a with
    | nil => simp [openAt] at h
    | cons d a =>
      cases d with
      | left =>
        simp only [openAt, Option.map_eq_some_iff] at h
        obtain ⟨⟨v', p'⟩, h1, h2⟩ := h
        simp at h2; obtain ⟨rfl, rfl⟩ := h2
        rw [climb_append, ihl a v' p' h1]; simp [climb, root]
      | right =>
        simp only [openAt, Option.map_eq_some_iff] at h
        obtain ⟨⟨v', p'⟩, h1, h2⟩ := h
        simp at h2; obtain ⟨rfl, rfl⟩ := h2
        rw [climb_append, ihr a v' p' h1]; simp [climb, root]

theorem open_verifies (H : Hash) (t : Tree) (a : List Dir) (v : UInt64) (p : Path)
    (h : openAt H t a = some (v, p)) : verifyOpening H (root H t) v p = true := by
  simp [verifyOpening, open_complete H t a v p h]

/-- Binding is an assumption. We state what a collision
    would look like and make the trust explicit as a
    hypothesis, never as an `axiom`. -/
def CollisionFree (H : Hash) : Prop :=
  ∀ a b c d, H a b = H c d → a = c ∧ b = d

/-- Under collision freedom, two openings of the same
    position along the same sibling path agree on the
    leaf. -/
theorem binding (H : Hash) (hH : CollisionFree H) :
    ∀ (p : Path) (v v' : UInt64), climb H v p = climb H v' p → v = v' := by
  intro p
  induction p with
  | nil => intro v v' h; exact h
  | cons hd tl ih =>
    obtain ⟨d, s⟩ := hd
    intro v v' h
    cases d with
    | left  => exact (hH _ _ _ _ (ih _ _ h)).1
    | right => exact (hH _ _ _ _ (ih _ _ h)).2

def demo : Tree := .node (.node (.leaf 10) (.leaf 20)) (.node (.leaf 30) (.leaf 40))

#eval (openAt toyHash demo [.right, .left]).map fun (v, p) =>
  (v, verifyOpening toyHash (root toyHash demo) v p)

end PI.Merkle
