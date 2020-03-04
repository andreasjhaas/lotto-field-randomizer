import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotto Field Rondomizer',
      debugShowCheckedModeBanner: false,
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
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Lotto Field Rondomizer'),
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

class LottoField{
  int number;
  bool ticked;

  LottoField(this.number, this.ticked);

  isTicked(){
    return ticked;
  }

  setTicked(bool tick){
    ticked = tick;
  }

  getNumber(){
    return number;
  }

}

class _MyHomePageState extends State<MyHomePage> {
  List<LottoField> lf = [];
  TextEditingController superTC = new TextEditingController();

  @override
  initState() {
    super.initState();
    for(int i = 0;i <= 48;i++){
      lf.add(LottoField(i+1,false));
    }
    ShakeDetector sd = ShakeDetector.waitForStart(
        onPhoneShake: () {
          tickFields();
        }
    );
    sd.startListening();
  }

  tickFields(){
    setState(() {
      for(int i = 0;i <= 48;i++){
        if(lf[i].isTicked()){
          lf[i].setTicked(false);
        }
      }
      superTC.text = "";

      Random r = new Random();
      for(int i = 0;i <= 5;i++){
        var result;
        do{
          result = r.nextInt(49);
        }
        while(lf[result].isTicked());
        lf[result].setTicked(true);
      }

      superTC.text = r.nextInt(10).toString();
    });
  }

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
      body: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: SingleChildScrollView(
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
                            child: Text(lf[0].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[0].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[0].setTicked(value);
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
                            child: Text(lf[1].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[1].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[1].setTicked(value);
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
                            child: Text(lf[2].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[2].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[2].setTicked(value);
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
                            child: Text(lf[3].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[3].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[3].setTicked(value);
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
                            child: Text(lf[4].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[4].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[4].setTicked(value);
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
                            child: Text(lf[5].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[5].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[5].setTicked(value);
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
                            child: Text(lf[6].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[6].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[6].setTicked(value);
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
                            child: Text(lf[7].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[7].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[7].setTicked(value);
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
                            child: Text(lf[8].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[8].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[8].setTicked(value);
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
                            child: Text(lf[9].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[9].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[9].setTicked(value);
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
                            child: Text(lf[10].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[10].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[10].setTicked(value);
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
                            child: Text(lf[11].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[11].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[11].setTicked(value);
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
                            child: Text(lf[12].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[12].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[12].setTicked(value);
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
                            child: Text(lf[13].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[13].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[13].setTicked(value);
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
                            child: Text(lf[14].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[14].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[14].setTicked(value);
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
                            child: Text(lf[15].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[15].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[15].setTicked(value);
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
                            child: Text(lf[16].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[16].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[16].setTicked(value);
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
                            child: Text(lf[17].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[17].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[17].setTicked(value);
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
                            child: Text(lf[18].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[18].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[18].setTicked(value);
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
                            child: Text(lf[19].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[19].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[19].setTicked(value);
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
                            child: Text(lf[20].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[20].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[20].setTicked(value);
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
                            child: Text(lf[21].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[21].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[21].setTicked(value);
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
                            child: Text(lf[22].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[22].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[22].setTicked(value);
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
                            child: Text(lf[23].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[23].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[23].setTicked(value);
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
                            child: Text(lf[24].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[24].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[24].setTicked(value);
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
                            child: Text(lf[25].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[25].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[25].setTicked(value);
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
                            child: Text(lf[26].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[26].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[26].setTicked(value);
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
                            child: Text(lf[27].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[27].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[27].setTicked(value);
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
                            child: Text(lf[28].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[28].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[28].setTicked(value);
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
                            child: Text(lf[29].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[29].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[29].setTicked(value);
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
                            child: Text(lf[30].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[30].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[30].setTicked(value);
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
                            child: Text(lf[31].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[31].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[31].setTicked(value);
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
                            child: Text(lf[32].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[32].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[32].setTicked(value);
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
                            child: Text(lf[33].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[33].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[33].setTicked(value);
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
                            child: Text(lf[34].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[34].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[34].setTicked(value);
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
                            child: Text(lf[35].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[35].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[35].setTicked(value);
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
                            child: Text(lf[36].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[36].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[36].setTicked(value);
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
                            child: Text(lf[37].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[37].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[37].setTicked(value);
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
                            child: Text(lf[38].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[38].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[38].setTicked(value);
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
                            child: Text(lf[39].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[39].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[39].setTicked(value);
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
                            child: Text(lf[40].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[40].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[40].setTicked(value);
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
                            child: Text(lf[41].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[41].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[41].setTicked(value);
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
                            child: Text(lf[42].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[42].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[42].setTicked(value);
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
                            child: Text(lf[43].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[43].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[43].setTicked(value);
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
                            child: Text(lf[44].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[44].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[44].setTicked(value);
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
                            child: Text(lf[45].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[45].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[45].setTicked(value);
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
                            child: Text(lf[46].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[46].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[46].setTicked(value);
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
                            child: Text(lf[47].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[47].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[47].setTicked(value);
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
                            child: Text(lf[48].getNumber().toString()),
                          ),
                          Center(
                            child: Checkbox(
                              value: lf[48].isTicked(),
                              onChanged: (bool value) {
                                setState(() {
                                  lf[48].setTicked(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Superzahl",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  width: 50,
                  child:TextField(
                    controller: superTC,
                    textAlign: TextAlign.center,
                    enabled: false,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
