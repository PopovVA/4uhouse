List<int> generateRangeList(List<int> range) {
	int first = range[0];
	int last = range[1];
	return List.generate(last - first + 1, (int index) => first + index);
}
