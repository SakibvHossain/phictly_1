String? dateValidation(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Age cannot be empty";
  }

  final trimmed = value.trim();

  // Check if input contains only digits
  if (!RegExp(r'^\d+$').hasMatch(trimmed)) {
    return "Please enter numbers only";
  }

  int age = int.parse(trimmed);

  if (age < 14) {
    return "Age must be 14+";
  } else if (age > 100) {
    return "Please enter a realistic age (under 100)";
  }

  return null; // ✅ valid
}
