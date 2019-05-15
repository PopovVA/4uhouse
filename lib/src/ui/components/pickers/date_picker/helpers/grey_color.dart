List<int> greyColourInclude(List<int> res, int n) {
  List<int> result = List.from(res);
  for (var i = 0; i < n; i++) {
    result[i] = -result[i].abs();
  }

  return result;
}

List<int> greyColourBegin(List<int> res, int n) {
  List<int> result = List.from(res);
  for (var i = n; i < res.length; i++) {
    result[i] = -result[i].abs();
  }

  return result;
}
