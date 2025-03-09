String? dateValidation(String? name) {
  if (name!.trim().isEmpty) {
    return "Date cannot be empty";
  }
  return null;
}