/// Configuration options for fake factory generation.
///
/// Extracted from [FakeIt] annotation to decouple config from annotation.
class FakerConfig {
  const FakerConfig({
    this.seed,
    required this.generateNullForNullable,
    required this.nullProbability,
  });

  /// Optional seed for reproducible fake data generation.
  final int? seed;

  /// Whether to randomly generate null for nullable fields.
  final bool generateNullForNullable;

  /// The probability (0.0 to 1.0) that a nullable field will be null.
  final double nullProbability;
}
