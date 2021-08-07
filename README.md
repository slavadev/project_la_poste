# Project LaPoste

Project LaPoste is a gem that allows you to calculate delivery prices and
discounts following predefined rules.

## Usage

To run LaPoste you need provide a file with transactions(`input.txt` is used by
default):

    $ bin/run your_input.txt

To run tests

    $ bin/setup
    $ bin/test

## Highlights

- Project LaPoste is designed as a gem, which allows you to easily integrate it to your project or run independently
- It's designed to be easily changeable and extendable. Things which are especially easy to add:
  - New providers and new [sources of providers](lib/la_poste/providers_sources)
  - New [producers of transactions](lib/la_poste/transaction_producers)
  - New [rules](lib/la_poste/rules)
- The code:
  - Is covered by tests
  - Follows [style guides](https://github.com/rubocop/rubocop)
  - Includes [YARD](https://yardoc.org/) documentation comments
  - Has clear commits history following [Conventional Commits specification](https://conventionalcommits.org)
  - Is automatically [checked](https://github.com/slavadev/project_la_poste/actions) by CI(Github Actions)

## Next steps:

- **(Important)** Replace `Float` type with some kind of `Money` class([1](https://github.com/RubyMoney/money),[2](https://github.com/Shopify/money)) in all places where we deal with money. It will save us from rounding and other nasty problems.
- Add test coverage reports
- Add some kind of monitoring, e.g. DataDog
- *(Optional)* Add [Sorbet](https://sorbet.org/) types it team is interested
