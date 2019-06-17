import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class ScreenEvent extends Equatable {
  ScreenEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class ScreenInitialized extends ScreenEvent {
  @override
  String toString() => 'ScreenInitialized';
}

class TappedOnComponent extends ScreenEvent {
  @override
  String toString() => 'SubmitCodeTapped';
}
