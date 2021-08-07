# Rules

Rules are the core functionality of LaPoste. Each rule has it's own storage,
which make it possible to use completely different storages(DB, files, etc.).
Also it allows to implement rules independently - you can use even implement
some rules as RPCs.

Each rule should has a `#call` method which takes transaction as a param and
changes it's price or discount if needed.

Generally, rules are independet from each other, but sometimes the order is
important, e.g. you might want to run rules which set prices first and rules
which limit discounts last.
