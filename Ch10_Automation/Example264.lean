-- Book listing around line 5517 (Ch10_Automation).
example (x y : Int) :
    27 ≤ 11 * x + 13 * y →
    11 * x + 13 * y ≤ 45 →
    -10 ≤ 7 * x - 9 * y →
    7 * x - 9 * y ≤ 4 →
    False := by
  grind
