import 'package:flutter/material.dart';
import 'package:homework_2/app/features/home/widgets/film_list.dart';
import 'package:homework_2/app/features/settings/pages/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[100],
      appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return SettingsPage(
                        arguments: const SettingsArguments('BOBIK'),
                      );
                    },
                  ),
                );
              },
            ),


          ]),
      body: const FilmList(),
    );
  }
}
