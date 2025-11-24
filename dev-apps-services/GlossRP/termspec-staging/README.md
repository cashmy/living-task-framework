# TermSpec Staging Area

Drop draft or validated TermSpec `.md` files in this directory while testing GlossRP locally. The service learns where this folder lives via the `TERMSPEC_DIRECTORY` setting (see `.env.example`).

Nothing inside this folder is committed to git except this README and the `.gitkeep` placeholder. That keeps real TermSpecs private while still giving the watcher/ingestion pipeline a predictable place to look.
