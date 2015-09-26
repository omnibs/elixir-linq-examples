101 LINQ Samples in Elixir
==================

Port of [C#'s' 101 LINQ Samples](http://code.msdn.microsoft.com/101-LINQ-Samples-3fb9811b) translated into Elixir.

Compare Elixir to other LINQ examples written in:

 - [Clojure](https://github.com/mythz/clojure-linq-examples)
 - [Java](https://github.com/mythz/java-linq-examples)
 - [Swift](https://github.com/mythz/swift-linq-examples)
 - [Dart](https://github.com/mythz/dart-linq-examples)

### Pretty pretty please!

Open an issue if you think I'm doing something stupid in any of the examples or if you have a better way of doing any of them. I'm beginning Elixir, as anyone who stumble here might also be, so this is whole point. :)

### Running the examples

The examples are coded as unit tests. For sanity, I've commented out all of the IO.

Be sure to get all dependencies before running the examples for the first time. Do so with:

    mix deps.get

Execute all of the examles with:

    mix test

### Contents

The samples below mirror the C# LINQ samples in the form of `ExUnit` unit tests with test names matching their corresponding C# examples.

#### [LINQ - Restriction Operators](https://github.com/omnibs/elixir-linq-examples/blob/master/test/restriction_test.exs) / [MSDN C#](http://code.msdn.microsoft.com/LINQ-to-DataSets-09787825)
#### [LINQ - Projection Operators](https://github.com/omnibs/elixir-linq-examples/blob/master/test/projection_test.exs) / [MSDN C#](http://code.msdn.microsoft.com/LINQ-Partitioning-Operators-c68aaccc)
#### [LINQ - Partitioning Operators](https://github.com/omnibs/elixir-linq-examples/blob/master/test/partitioning_test.exs) / [MSDN C#](http://code.msdn.microsoft.com/SQL-Ordering-Operators-050af19e)
#### [LINQ - Ordering Operators](https://github.com/omnibs/elixir-linq-examples/blob/master/test/ordering_test.exs) / [MSDN C#](http://code.msdn.microsoft.com/SQL-Ordering-Operators-050af19e)
#### [LINQ - Grouping Operators](https://github.com/omnibs/elixir-linq-examples/blob/master/test/grouping_test.exs) / [MSDN C#](http://code.msdn.microsoft.com/LINQ-to-DataSets-Grouping-c62703ea)
#### More to come...

### TODO

- [x] Implement Restriction Operators examples
- [x] Implement Projection Operators examples
- [x] Implement Partitioning Operators examples
- [x] Implement Ordering Operators examples
- [x] Implement Grouping Operators examples
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