import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var lft = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49];
  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1[0],
                          onChanged: (bool value) {
                            setState(() {
                              cb1[0] = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(lft[0].toString()),
                      ),
                      Center(
                        child: Checkbox(
                          value: cb1,
                          onChanged: (bool value) {
                            setState(() {
                              cb1 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
