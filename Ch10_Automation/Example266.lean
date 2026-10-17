-- Book listing around line 5549 (Ch10_Automation).
example (x y : Int) : x * y = y * x := by
  grind
-- may succeed via ring, or need `grind +ring`
