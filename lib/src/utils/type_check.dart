bool isNotNull(Object o) {
  return o != null;
}

// ignore: always_specify_types
bool isNotNullableString(string) {
  return (string is String) && (string.isNotEmpty);
}
