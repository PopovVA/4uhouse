import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class ScreenEvent extends Equatable {
  ScreenEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class ScreenInitialized extends ScreenEvent {
  ScreenInitialized({this.query});

  final String query;

  @override
  String toString() => 'ScreenInitialized';
}

class TappedOnComponent extends ScreenEvent {
  @override
  String toString() => 'SubmitCodeTapped';
}

class SendItem extends ScreenEvent {
  SendItem({this.route, this.value, this.body});

  final String route;
  final dynamic value;
  final dynamic body;

  @override
  String toString() => 'SendItem';
}
