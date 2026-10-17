# Contributing

Thank you for reading *Lean Programming for AI Agents* and for checking the listings.

## Errata

The useful contribution is a clear report of a mistake: a wrong listing, a typesetting error, a broken instruction, or a page that no longer matches this repository.

1. Open a GitHub issue with the **Errata** template.
2. Give a location: chapter, page, or file path (`Ch03_InductiveTypes/Vec.lean`).
3. Quote what the book or file says, and what it should say.
4. Mention your Lean version (`lean --version`) if the issue is a compile failure.

Please do not send drive-by listing rewrites that change the teaching order of the book. Small, targeted fixes that make a printed listing match this package (or the other way around) are welcome as pull requests once the errata issue exists.

## Building before you patch

```bash
source "$HOME/.elan/env"
lake build
lake exe checker --self-test
```

Keep `*_Fails.lean` files as comments unless the book listing itself should compile.

## Licence

Code you contribute to this repository is MIT, matching [LICENSE](LICENSE). The book text and cover remain copyright Abdul Jaleel Kavungal, all rights reserved.
