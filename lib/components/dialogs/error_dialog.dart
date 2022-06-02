import 'package:flutter/material.dart';
import 'package:homework_6/components/constants.dart';
import 'package:homework_6/presentation/home/home_screen.dart';

/// Функция вызова диалога ошибки
void showErrorDialog({BuildContext? context, required String error}) {
  final _context = context ?? HomeScreen.globalKey.currentContext;
  if (_context != null) {
    showDialog(
      context: _context,
      builder: (_) => ErrorDialog(error),
    );
  }
}

/// Простой диалог отображения ошибки
class ErrorDialog extends StatelessWidget {
  final String? error;

  const ErrorDialog(this.error, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(36),
          decoration: const BoxDecoration(
            color: MovieColors.greyColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  CloseButton(color: Colors.white),
                ],
              ),
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                '${MovieLocal.error} ${error ?? MovieLocal.unknown}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
