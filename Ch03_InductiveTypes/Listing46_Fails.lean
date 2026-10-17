-- Book listing around line 1069 (Ch03_InductiveTypes).
-- rejected by the kernel (strict positivity)

-- -- Rejected. `Bad` occurs to the left of an arrow in its own constructor.
-- -- inductive Bad where
-- --   | mk : (Bad → Nat) → Bad
