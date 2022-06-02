import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homework_6/components/dialogs/error_dialog.dart';
import 'package:homework_6/error_bloc/error_event.dart';
import 'package:homework_6/error_bloc/error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(const ErrorState()) {
    on<ShowDialogEvent>(_onShowDialog);
  }

  void _onShowDialog(ShowDialogEvent event, Emitter<ErrorState> emit) {
    showErrorDialog(error: '${event.title} ${event.message}');
  }
}
