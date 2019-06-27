import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
abstract class ComponentEvent extends Equatable {
  ComponentEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class SendingComponentValueRequested extends ComponentEvent {
  SendingComponentValueRequested({this.route, this.value, this.body});

  final String route;
  final dynamic value;
  final dynamic body;

  @override
  String toString() => 'SendingComponentValueRequested';
}