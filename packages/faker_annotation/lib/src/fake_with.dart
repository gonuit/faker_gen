/// Annotation to specify a custom fake function for a field.
///
/// Use this annotation on fields that have dynamic, Object, or other types
/// that cannot be automatically faked. The specified function will be called
/// to generate fake values for this field.
///
/// The function must be a top-level function that takes a [Randomizer] as its
/// first parameter and returns the appropriate type for the field.
///
/// ## Example
///
/// ```dart
/// // Define a top-level fake function
/// Map<String, Object?> fakeRating(Randomizer r) => {
///   'score': r.nextInt(min: 1, max: 6),
///   'comment': r.nextString(),
/// };
///
/// @FakeIt()
/// class Product {
///   final String name;
///
///   @FakeWith(fakeRating)
///   final Map<String, Object?> rating;
///
///   Product({required this.name, required this.rating});
/// }
/// ```
///
/// The generated fake function will call `fakeRating(r)` to generate
/// values for the `rating` field.
class FakeWith {
  /// Creates a [FakeWith] annotation.
  ///
  /// [fakeFunction] - A top-level function that generates fake values.
  /// The function signature should be: `T functionName(Randomizer r)`
  const FakeWith(this.fakeFunction);

  /// The top-level function to use for generating fake values.
  final Function fakeFunction;
}
