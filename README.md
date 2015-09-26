101 LINQ Samples in Elixir
==================

Port of [C#'s' 101 LINQ Samples](http://code.msdn.microsoft.com/101-LINQ-Samples-3fb9811b) translated into Elixir.

Compare Elixir to other LINQ examples written in:

 - [Clojure](https://github.com/mythz/clojure-linq-examples)
 - [Java](https://github.com/mythz/java-linq-examples)
 - [Swift](https://github.com/mythz/swift-linq-examples)
 - [Dart](https://github.com/mythz/dart-linq-examples)

### Disclaimer

I'm doing this as an exercise on learning Elixir, so my code might not be optimal. I welcome criticism and refactor suggestions, different approaches to queries, etc. :)

### Running the examples

The examples are coded as unit tests. For sanity, I've commented out all of the IO.

Be sure to get all dependencies before running the examples for the first time. Do so with:

    mix deps.get

Execute all of the examles with:

    mix test

### TODO

- [x] Implement Restriction Operators examples
- [x] Implement Projection Operators examples
- [x] Implement Partitioning Operators examples
- [x] Implement Ordering Operators examples
- [ ] Implement Grouping Operators examples
- [ ] Implement Set Operators examples
- [ ] Implement Conversion Operators examples
- [ ] Implement Element Operators examples
- [ ] Implement Generation Operators examples
- [ ] Implement Quantifiers / examples
- [ ] Implement Aggregate Operators examples
- [ ] Implement Miscellaneous Operators examples
- [ ] Implement Query Execution examples
- [ ] Implement Join Operators examples
- [ ] Use ericmj's Decimal instead of Elixir's float
- [ ] Make examples with `for`, `Enum.` and `Stream.` for every case
- [ ] When Poison 2.0 is out, change `get_customer_list/0` code to use it's nested structs support