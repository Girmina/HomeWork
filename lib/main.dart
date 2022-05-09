import 'package:flutter/material.dart';
import 'package:homework_2/app/features/settings/pages/settings_page.dart';
import 'package:homework_2/app/features/widgets/main_page.dart';
import 'package:homework_2/app/features/widgets/not_found_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Films',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MainPage(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == MainPage.path) {
          return MaterialPageRoute(
            builder: (context) {
              return const MainPage();
            },
          );
        }

        if (settings.name == SettingsPage.path) {
          final SettingsArguments arguments =
          settings.arguments as SettingsArguments;
          return MaterialPageRoute(
            builder: (context) {
              return SettingsPage(
                arguments: arguments,
              );
            },
          );
        }

        return MaterialPageRoute(
          // Более короткая версия функции
          // (_, __, ___ и так далее) обозначают неиспользуемые параметры
          builder: (_) => const NotFoundPage(),
        );
      },


    );
  }
}
