List<int> generateRangeList(List<int> range) {
  final int first = range[0];
  final int last = range[1];
  // ignore: always_specify_types
  return List.generate(last - first + 1, (int index) => first + index);
}
