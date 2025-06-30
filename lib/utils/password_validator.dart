String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    // If the field is empty
    return 'Password cannot be empty';
  } else if (value.length < 8) {
    // If the password is shorter than 8 characters
    return 'Password must be at least 8 characters long';
  }
  // You can add more conditions here (e.g., at least one digit, one uppercase letter, etc.)

  // If the input is valid
  return null;
}
