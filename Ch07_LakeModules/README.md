# Chapter 7

Projects, Lake, Modules, and the 2026 Toolchain

Live modules:

- `main.lean`
- `ToolResult.lean`
- `Listing191.lean`

Deliberately failing, rejected, or out-of-scope listings (quoted as comments, or kept out of the default build):

- `Listing183_Fails.lean`: not a standalone module; quoted so lake build stays green
- `Myagent/Spec_Fails.lean`: module-system sketch that expects a standalone `Myagent` layout
- `Myagent/SpecLemmas_Fails.lean`: module-system sketch that expects a standalone `Myagent` layout
- `revArrays_Fails.lean`: not a standalone module; quoted so lake build stays green
- `Listing188_Fails.lean`: not a standalone module; quoted so lake build stays green
- `checkLine_Fails.lean`: not a standalone module; quoted so lake build stays green
- `ToolResult_190_Fails.lean`: not a standalone module; quoted so lake build stays green
- `Myagent_Fails.lean`: module-system sketch that expects a standalone `Myagent` layout

The finished `Myagent` library lives in `Ch18_WorkedAgent/`.
