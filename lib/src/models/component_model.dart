class ComponentModel {
	String _component;

	ComponentModel.fromJson(String component)
		: _component = component;

	String get component => _component;
}
