import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/faker_generator.dart';

/// The builder factory for the faker generator.
///
/// This is the entry point used by build_runner to create the generator.
Builder fakerBuilder(BuilderOptions options) =>
    SharedPartBuilder([FakerGenerator()], 'faker');
