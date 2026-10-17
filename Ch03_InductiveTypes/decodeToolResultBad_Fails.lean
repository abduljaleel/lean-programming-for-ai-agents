-- Book listing around line 1335 (Ch03_InductiveTypes).
-- junk-drawer decoder the book tells you not to write

-- -- Do not do this. You have reintroduced untyped JSON.
-- def decodeToolResultBad (j : JValue) : ToolResult JValue :=
--   match (j.get? "tag" >>= JValue.asStr?) with
--   | some "ok" => .ok (j.get? "value" |>.getD .null)
--   | some r    => .failed r
--   | none      => .failed "???"
