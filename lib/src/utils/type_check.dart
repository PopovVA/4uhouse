bool isNotNull(Object o) {
  return o != null;
}

bool isNotNullableString(string) {
  return (string is String) && (string.length > 0);
}
