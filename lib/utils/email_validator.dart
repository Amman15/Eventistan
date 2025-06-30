String? emailValidator(String? value) {
  // Regular expression for validating an email
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  if (value == null || value.isEmpty) {
    // If the field is empty
    return 'Email cannot be empty';
  } else if (!emailRegExp.hasMatch(value)) {
    // If the email does not match the pattern
    return 'Enter a valid email address';
  }
  // If the input is valid
  return null;
}
