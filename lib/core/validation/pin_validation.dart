String? validatePin(String? value) {
  if (value == null || value.isEmpty) {
    return 'PIN cannot be empty';
  }
  if (value.length != 6) {
    return 'PIN must be exactly 6 digits';
  }
  if (!RegExp(r'^\d{6}$').hasMatch(value)) {
    return 'PIN must contain only numbers';
  }
  return null;
}
