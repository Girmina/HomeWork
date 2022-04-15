import 'package:flutter/material.dart';
import 'package:untitled2/main.dart';
//import 'package:http/http.dart' as http;
import 'main.dart';

//Урок 3.
// простой список
/*

*void main() =>  runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            body: new ListView(children: [
              new Text('0000'),
              new Divider(),
              new Text('0001'),
              new Divider(),
              new Text('0010'),
            ])// ListView
        )// Scaffold
    )// MaterialApp
);
*/
//бесконечный список
/*
void main () {
  runApp(
      new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new Scaffold(
              body: new ListView.builder(
                  itemBuilder: (context, index) {
                     return new Text('линия $index');
                  },
          )
          )
      )
  );
}
*/
/*
//Описание массива в
class MyBody extends StatefulWidget {

  @override
  createState () => new MyBodyState();
  }
  class MyBodyState extends State<MyBody>{
  List<String> _array = [];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(itemBuilder: (context, i) {
      print('num $i : нечетное = ${i.isOdd}');

      if (i.isOdd) return new Divider();

      final int index = i ~/2;

    print ('index $index');
    print ('lenght $_array.lenght');
    if (index >= _array.length) _array.addAll(['$index','${index + 1}', '${index + 2}']);

    return new ListTile(title: new Text(_array[index]));
  });
  }
 } //запуск приложения
void main () => runApp(
  new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Scaffold(body: new Center(child: new MyBody(),))
  )
);
*/
//Урок 4
/*
class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(
            50.0), //виджет формы мы обернули контейнером с отступами
        child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                new Text(
                  'Имя пользователя:',
                  style: TextStyle(fontSize: 20.0, color: Colors.amber),
                ), //добавили заголовок перед полем ввода
                new TextFormField(validator: (value) {
                  //виджет текстового поля ввода| ту функцию будет инициализировать виджет Form, когда мы обратимся к ней для проверки данных _formKey.currentState.validate()
                  if (value!.isEmpty)
                    return 'Пожалуйста введите свое имя'; //проверяем значение в форме, если оно пустое isEmpty, значит возвращаем строку-ошибку
                }),

                new SizedBox(
                    height:
                        80.0), //оздаем контейнер для визуального разделения виджетов между собой по вертикали

                new RaisedButton(
                  onPressed: () {
                    //cоздаем виджет кнопки, в предыдущих уроках мы использовали FlatButton (это непринципиально)
                    if (_formKey.currentState!
                        .validate()) //проверяем, проходят ли проверку поля ввода, если у полей ввода есть функции проверки в параметре validator. Чтобы _formKey.currentState.validate() вернул значение true == в полях нет ошибок, все функции должны вернуть значение null (т.е. ничего не возвращать или return null)
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Форма успешно заполнена'),
                        backgroundColor: Colors.greenAccent[200],
                      )); //Если какое-то поле вернуло ошибку, то под полем появится сообщение об ошибке. Если все поля прошли проверку, мы вызываем всплывающее уведомление внизу экрана.
                  },
                  child: Text('Проверить'),
                  color: Colors.indigo,
                  textColor: Colors.white,
                ),
              ],
            )));
  }
}

void main() => runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Scaffold(
        appBar: new AppBar(title: new Text('Flutter.su - Форма ввода')),
        body: new MyForm() //вызов класса
        )));
*/
/*
//Урок 4.

enum GenderList { male, female }

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  late GenderList _gender;
  bool _agreement = false;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        // ignore: unnecessary_new
        child: new Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                new Text(
                  'Имя пользователя:',
                  style: TextStyle(fontSize: 20.0),
                ),
                new TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Пожалуйста введите свое имя';
                }),
                new SizedBox(height: 20.0),
                new Text(
                  'Контактный E-mail:',
                  style: TextStyle(fontSize: 20.0),
                ),
                new TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Пожалуйста введите свой Email';

                  String p =
                      "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
                  RegExp regExp = new RegExp(p);

                  if (regExp.hasMatch(value)) return null;

                  return 'Это не E-mail';
                }),
                new SizedBox(height: 20.0),
                new Text(
                  'Ваш пол:',
                  style: TextStyle(fontSize: 20.0),
                ),
                new RadioListTile(
                  title: const Text('Мужской'),
                  value: GenderList.male,
                  groupValue: _gender,
                  onChanged: (GenderList.values) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                new RadioListTile(
                  title: const Text('Женский'),
                  value: GenderList.female,
                  groupValue: _gender,
                  onChanged: (GenderList value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                new SizedBox(height: 20.0),
                new CheckboxListTile(
                    value: _agreement,
                    title: new Text('Я ознакомлен' +
                        (_gender == null
                            ? '(а)'
                            : _gender == GenderList.male
                                ? ''
                                : 'а') +
                        ' с документом "Согласие на обработку персональных данных" и даю согласие на обработку моих персональных данных в соответствии с требованиями "Федерального закона О персональных данных № 152-ФЗ".'),
                    onChanged: (bool value) =>
                        setState(() => _agreement = value)),
                new SizedBox(height: 20.0),
                new RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Color color = Colors.red;
                      String text;

                      if (_gender == null)
                        text = 'Выберите свой пол';
                      else if (_agreement == false)
                        text = 'Необходимо принять условия соглашения';
                      else {
                        text = 'Форма успешно заполнена';
                        color = Colors.green;
                      }

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(text),
                        backgroundColor: color,
                      ));
                    }
                  },
                  child: Text('Проверить'),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            )));
  }
}

void main() => runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Scaffold(
        appBar: new AppBar(title: new Text('Flutter.su - Форма ввода')),
        body: new MyForm())));
*/

//==========================================================================Урок 5. Навигация
//=====================================Открытие нового окна и возврат к предыдущему
/*
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Главное окно')),
      body: Center(
          child: RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondScreen()));
              },
              child: Text('Открыть второе окно'))),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Второе окно')),
      body: Center(
          child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Назад'))),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MainScreen(),
  ));
}
*/
//==========================================Использование маршрутов для навигации – routes
/*
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Главное окно')),
      body: Center(
          child: Column(
        children: [
          RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: Text('Открыть второе окно'))
        ],
      )),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Второе окно')),
      body: Center(
          child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Назад'))),
    );
  }
}

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (BuildContext context) => MainScreen(),
    '/second': (BuildContext context) => SecondScreen()
  }));
}

 */

//===================================Передача параметров в маршруте с помощью события onGenerateRoute
/*
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Главное окно')),
      body: Center(
          child: Column(
        children: [
          RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: Text('Открыть второе окно')),
          RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second/123');
              },
              child: Text('Открыть второе окно 123')),
        ],
      )),
    );
  }
}

class SecondScreen extends StatelessWidget {
  String _id;

  SecondScreen({required String id}) : _id = id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Второе окно $_id')),
      body: Center(
          child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Назад'))),
    );
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => MainScreen(),
      '/second': (BuildContext context) => SecondScreen(
            id: '',
          )
    },
    onGenerateRoute: (routeSettings) {
      var path = routeSettings.name!.split('/');

      if (path[1] == "second") {
        return new MaterialPageRoute(
          builder: (context) => new SecondScreen(id: path[2]),
          settings: routeSettings,
        );
      }
    },
  ));
}
*/

//=====================Открытие диалогового окна
/*
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Больше или меньше')),
      body: Center(
          child: Column(
        children: [
          RaisedButton(
              onPressed: () {
                var push = Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) => MyPopup(),
                        transitionsBuilder: (___, Animation<double> animation,
                            ____, Widget child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        }));
              },
              child: Text('Загадать число')),
        ],
      )),
    );
  }
}

class MyPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ваш ответ:'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Больше'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Меньше'),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(home: MainScreen()));
}
*/
//===============Возвращаемое значение из диалогового окна
/*
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Больше или меньше')),
      body: Center(
          child: Column(
        children: [
          RaisedButton(
              onPressed: () async {
                bool value = await Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) => MyPopup(),
                        transitionsBuilder: (___, Animation<double> animation,
                            ____, Widget child) {
                          return FadeTransition(
                            opacity: animation,
                            child:
                                ScaleTransition(scale: animation, child: child),
                          );
                        }));

                if (value)
                  _scaffoldKey.currentState!.showSnackBar(SnackBar(
                    content: Text('Больше'),
                    backgroundColor: Colors.green,
                  )); // TRUE
                else
                  _scaffoldKey.currentState!.showSnackBar(SnackBar(
                    content: Text('Меньше'),
                    backgroundColor: Colors.red,
                  )); // FALSE
              },
              child: Text('Загадать число')),
        ],
      )),
    );
  }
}

class MyPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ваш ответ:'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text('Больше'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text('Меньше'),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(home: MainScreen()));
}
*/
// Урок 6. ===================Асинхронные методы async и await

class SandGlass {
  int _sand = 0;

  time() {
    return _sand;
  } //time

  Future tick() async {
    _sand = 100;
    print('Start:tick');
    while (_sand > 0) {
      print('tick: _sand');
      _sand--;
      await new Future.delayed(const Duration(milliseconds: 100));
    } //while
    print('End:tick');
  } //tick
} //SandGlass

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State {
  SandGlass clock = SandGlass();

  _reDrawWidget() async {
    if (clock.time() == 0) return;
    await new Future.delayed(const Duration(seconds: 1));
    setState(() {
      print('reDrawWidget()');
    });
  }

  @override
  void initState() {
    clock.tick();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _reDrawWidget();

    print('clock.tick: ${clock.time()}');

    return Center(child: Text('time is: ${clock.time()}'));
  }
}

void main() => runApp(new MaterialApp(home: Scaffold(body: MyApp())));

//Урок 7. ====================HTTP и HTTPS, сетевые запросы в Dart и Flutter
