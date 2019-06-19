import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;
import '../../../src/models/screen/screen_model.dart';

@immutable
abstract class ScreenState extends Equatable {
  ScreenState([List<dynamic> props = const <dynamic>[]]) : super(props);

  @override
  String toString();
}

class ScreenUninitialized extends ScreenState {
  @override
  String toString() => 'ScreenUninitialized';
}

class ScreenLoading extends ScreenState {
  @override
  String toString() => 'ScreenLoading';
}

class ScreenDataLoaded extends ScreenState {
  ScreenDataLoaded(this.data);

  final List<ScreenModel> data;

  @override
  String toString() => 'ScreenDataLoaded';
}

class ScreenDataLoadingError extends ScreenState {
  ScreenDataLoadingError({this.error});

  final String error;

  @override
  String toString() => error;
}