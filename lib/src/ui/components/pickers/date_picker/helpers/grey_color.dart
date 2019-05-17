List<int> greyColourInclude(List<int> res, int n) {
  // ignore: always_specify_types
  final List<int> result = List.from(res);
  // ignore: always_specify_types
  for (var i = 0; i < n; i++) {
    result[i] = -result[i].abs();
  }

  return result;
}

List<int> greyColourBegin(List<int> res, int n) {
  // ignore: always_specify_types
  final List<int> result = List.from(res);
  // ignore: always_specify_types
  for (var i = n; i < res.length; i++) {
    result[i] = -result[i].abs();
  }

  return result;
}
