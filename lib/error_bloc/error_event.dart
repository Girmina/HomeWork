import 'package:equatable/equatable.dart';

abstract class ErrorEvent extends Equatable {
  const ErrorEvent();
  @override
  List<Object> get props => [];
}

class ShowDialogEvent extends ErrorEvent {
  final String? title;
  final String? message;

  const ShowDialogEvent({this.message, this.title});
  @override
  List<Object> get props => [title ?? 0, message ?? 0];
}
