String? phoneValidation(String? name) {
  if (name!.trim().isEmpty) {
    return "Phone cannot be empty";
  }
  return null;
}