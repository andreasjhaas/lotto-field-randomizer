import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:vibration/vibration.dart';

void main() => runApp(Toast());

class Toast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BotToast Demo',
        navigatorObservers: [BotToastNavigatorObserver()],
        home: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotto Field Randomizer',
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
        brightness: Brightness.dark,
        primaryColor: Colors.lightGreen,
        //accentColor: Colors.lightGreen,
        buttonColor: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'Lotto Field Randomizer'),
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
  String _jsonString = '{"lottozahlen":[{"zahl":"6","haeufigkeit":"100"},{"zahl":"32","haeufigkeit":"100"},{"zahl":"49","haeufigkeit":"100"},{"zahl":"38","haeufigkeit":"100"},{"zahl":"31","haeufigkeit":"100"},{"zahl":"26","haeufigkeit":"100"},{"zahl":"22","haeufigkeit":"100"},{"zahl":"33","haeufigkeit":"100"},{"zahl":"11","haeufigkeit":"100"},{"zahl":"42","haeufigkeit":"100"},{"zahl":"3","haeufigkeit":"100"},{"zahl":"43","haeufigkeit":"100"},{"zahl":"41","haeufigkeit":"100"},{"zahl":"25","haeufigkeit":"100"},{"zahl":"27","haeufigkeit":"100"},{"zahl":"36","haeufigkeit":"100"},{"zahl":"17","haeufigkeit":"100"},{"zahl":"9","haeufigkeit":"100"},{"zahl":"7","haeufigkeit":"100"},{"zahl":"29","haeufigkeit":"100"},{"zahl":"48","haeufigkeit":"100"},{"zahl":"47","haeufigkeit":"100"},{"zahl":"19","haeufigkeit":"100"},{"zahl":"4","haeufigkeit":"100"},{"zahl":"39","haeufigkeit":"100"},{"zahl":"37","haeufigkeit":"100"},{"zahl":"18","haeufigkeit":"100"},{"zahl":"1","haeufigkeit":"100"},{"zahl":"10","haeufigkeit":"100"},{"zahl":"24","haeufigkeit":"100"},{"zahl":"5","haeufigkeit":"100"},{"zahl":"2","haeufigkeit":"100"},{"zahl":"40","haeufigkeit":"100"},{"zahl":"16","haeufigkeit":"100"},{"zahl":"35","haeufigkeit":"100"},{"zahl":"34","haeufigkeit":"100"},{"zahl":"44","haeufigkeit":"100"},{"zahl":"30","haeufigkeit":"100"},{"zahl":"23","haeufigkeit":"100"},{"zahl":"46","haeufigkeit":"100"},{"zahl":"12","haeufigkeit":"100"},{"zahl":"14","haeufigkeit":"100"},{"zahl":"20","haeufigkeit":"100"},{"zahl":"15","haeufigkeit":"100"},{"zahl":"28","haeufigkeit":"100"},{"zahl":"21","haeufigkeit":"100"},{"zahl":"8","haeufigkeit":"100"},{"zahl":"45","haeufigkeit":"100"},{"zahl":"13","haeufigkeit":"100"}]}';
  bool showReloadButton = false;

  _callWebservice() async{
    BotToast.showLoading();

    var _url = "https://mdm.sw-aalen.de/";
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    await client.getUrl(Uri.parse(_url)).then((request){
      request.headers.set('content-type', 'application/json');
      return request.close();
    }).then((response){
      return response.transform(utf8.decoder).join();
    }).then((json){
      _jsonString = json;
      setState(() {
        showReloadButton = false;
      });
      BotToast.showText(text:"Statistics loaded");

    }).timeout(const Duration(seconds: 10)).catchError((handleError){
      print(handleError);
      setState(() {
        showReloadButton = true;
      });
      BotToast.showText(text:"Statistics unavailable");
    });

    BotToast.closeAllLoading();
  }

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

    setState(() {
      _callWebservice();
    });

  }

  vibratePhone() async{
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 300);
    }
  }

  tickFields(){
    vibratePhone();
    setState(() {
      for(int i = 0;i <= 48;i++){
        if(lf[i].isTicked()){
          lf[i].setTicked(false);
        }
      }
      superTC.text = "";

      Map<String, dynamic> _json = jsonDecode(_jsonString);
      var result = 0;
      for(var i = 0; i < _json['lottozahlen'].length; i++){
        result = result + int.parse(_json['lottozahlen'][i]['haeufigkeit']);
      }
      print("Max Range: "+result.toString());
      Random r = new Random();
      for(int i = 0;i < 6;i++){
        var rResult;
        var lz;
        do{
          rResult = r.nextInt(result+1);
          print("rResult: "+rResult.toString());
          var range = 0;
          for(var i = 0; i < _json['lottozahlen'].length; i++){
            print("Zwischen "+(range+1).toString()+" und "+(range + int.parse(_json['lottozahlen'][i]['haeufigkeit'])).toString()+" entspricht Lotto Zahl "+_json['lottozahlen'][i]['zahl'].toString());
            if(rResult > range && rResult <= (range + int.parse(_json['lottozahlen'][i]['haeufigkeit']))){
              lz = i;
            }
            range = range + int.parse(_json['lottozahlen'][i]['haeufigkeit']);
          }
        }while(lf[int.parse(_json['lottozahlen'][lz]['zahl'])-1].isTicked());
        lf[int.parse(_json['lottozahlen'][lz]['zahl'])-1].setTicked(true);
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
                              checkColor: Colors.lightGreen,
                              onChanged: null,
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
      floatingActionButton: AnimatedOpacity(
        opacity: showReloadButton ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: FloatingActionButton(
          onPressed: !showReloadButton ? null : () {
            _callWebservice();
          },
          child: Icon(Icons.autorenew),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
