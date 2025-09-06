typedef StringValidationCallback = String? Function(String? value);

typedef Action<T> = Function(T builder);

class ValidationBuilder {
  ValidationBuilder({String? localeName, this.optional = false, this.requiredMessage}) {}

  final bool optional;
  final String? requiredMessage;
  final List<StringValidationCallback> validations = [];

  /// Clears validation list and adds required validation if
  /// [optional] is false
  ValidationBuilder reset() {
    validations.clear();

    return this;
  }

  /// Adds new item to [validations] list, returns this instance
  ValidationBuilder add(StringValidationCallback validator) {
    validations.add(validator);
    return this;
  }

  /// Tests [value] against defined [validations]
  String? test(String? value) {
    for (var validate in validations) {
      // Return null if field is optional and value is null
      if (optional && (value == null || value.isEmpty)) {
        return null;
      }

      // Otherwise execute validations
      final result = validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  /// Returns a validator function for FormInput
  StringValidationCallback build() => test;

  /// Throws error only if [left] and [right] validators throw error same time.
  /// If [reverse] is true left builder's error will be displayed otherwise
  /// right builder's error. Because this is default behaviour on most of the
  /// programming languages.
  ValidationBuilder or(Action<ValidationBuilder> left, Action<ValidationBuilder> right, {bool reverse = false}) {
    // Create
    final v1 = ValidationBuilder();
    final v2 = ValidationBuilder();

    // Configure
    left(v1);
    right(v2);

    // Build
    final v1cb = v1.build();
    final v2cb = v2.build();

    // Test
    return add((value) {
      final leftResult = v1cb(value);
      if (leftResult == null) {
        return null;
      }
      final rightResult = v2cb(value);
      if (rightResult == null) {
        return null;
      }
      return reverse == true ? leftResult : rightResult;
    });
  }
}
