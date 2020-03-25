import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:LottoFieldRandomizer/statistics.dart';
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
        navigatorObservers: [BotToastNavigatorObserver()],
        home: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotto Field Randomizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightGreen,
        buttonColor: Colors.lightGreen,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.lightGreen,
          textTheme: ButtonTextTheme.primary
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.lightGreen,
        ),
      ),
      home: MyHomePage(title: 'Lotto Field Randomizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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

class TypewriterTween extends Tween<String> {
  TypewriterTween({String begin = '', String end})
      : super(begin: begin, end: end);

  String lerp(double t) {
    var cutoff = (end.length * t).round();
    return end.substring(0, cutoff);
  }
}

class LottoFields extends StatefulWidget{
  const LottoFields({ Key key, this.lf }) : super(key: key);

  final List<LottoField> lf;

  @override
  _LottoFieldsState createState() => _LottoFieldsState(lf);
}

class _LottoFieldsState extends State<LottoFields> {
  List<LottoField> lf;

  _LottoFieldsState(List<LottoField> lf){
    this.lf = lf;
  }

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(7,(index){
        return Row(
          children: List.generate(7,(index2){
            return Expanded(
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Text(lf[(index*7)+index2].getNumber().toString()),
                  ),
                  Center(
                    child: Checkbox(
                      value: lf[(index*7)+index2].isTicked(),
                      checkColor: Colors.lightGreen,
                      onChanged: null,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      }),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  List<LottoField> lf = [];

  TextEditingController superTC = new TextEditingController();
  String _jsonString = '{"lottozahlen":[{"zahl":"6","haeufigkeit":"100"},{"zahl":"32","haeufigkeit":"100"},{"zahl":"49","haeufigkeit":"100"},{"zahl":"38","haeufigkeit":"100"},{"zahl":"31","haeufigkeit":"100"},{"zahl":"26","haeufigkeit":"100"},{"zahl":"22","haeufigkeit":"100"},{"zahl":"33","haeufigkeit":"100"},{"zahl":"11","haeufigkeit":"100"},{"zahl":"42","haeufigkeit":"100"},{"zahl":"3","haeufigkeit":"100"},{"zahl":"43","haeufigkeit":"100"},{"zahl":"41","haeufigkeit":"100"},{"zahl":"25","haeufigkeit":"100"},{"zahl":"27","haeufigkeit":"100"},{"zahl":"36","haeufigkeit":"100"},{"zahl":"17","haeufigkeit":"100"},{"zahl":"9","haeufigkeit":"100"},{"zahl":"7","haeufigkeit":"100"},{"zahl":"29","haeufigkeit":"100"},{"zahl":"48","haeufigkeit":"100"},{"zahl":"47","haeufigkeit":"100"},{"zahl":"19","haeufigkeit":"100"},{"zahl":"4","haeufigkeit":"100"},{"zahl":"39","haeufigkeit":"100"},{"zahl":"37","haeufigkeit":"100"},{"zahl":"18","haeufigkeit":"100"},{"zahl":"1","haeufigkeit":"100"},{"zahl":"10","haeufigkeit":"100"},{"zahl":"24","haeufigkeit":"100"},{"zahl":"5","haeufigkeit":"100"},{"zahl":"2","haeufigkeit":"100"},{"zahl":"40","haeufigkeit":"100"},{"zahl":"16","haeufigkeit":"100"},{"zahl":"35","haeufigkeit":"100"},{"zahl":"34","haeufigkeit":"100"},{"zahl":"44","haeufigkeit":"100"},{"zahl":"30","haeufigkeit":"100"},{"zahl":"23","haeufigkeit":"100"},{"zahl":"46","haeufigkeit":"100"},{"zahl":"12","haeufigkeit":"100"},{"zahl":"14","haeufigkeit":"100"},{"zahl":"20","haeufigkeit":"100"},{"zahl":"15","haeufigkeit":"100"},{"zahl":"28","haeufigkeit":"100"},{"zahl":"21","haeufigkeit":"100"},{"zahl":"8","haeufigkeit":"100"},{"zahl":"45","haeufigkeit":"100"},{"zahl":"13","haeufigkeit":"100"}]}';
  String _statisticText = "load statistic";

  bool _isStatisticsLoaded = false;
  bool _isUIVisible = false;

  AnimationController controller;
  Animation<String> animation;

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
      _isStatisticsLoaded = true;
      BotToast.showText(text:"Statistics loaded");
      _statisticText = "show statistic";
      _reloadFAB();

    }).timeout(const Duration(seconds: 10)).catchError((handleError){
      print(handleError);
      _isStatisticsLoaded = false;
      BotToast.showText(text:"Statistics unavailable");
    });

    BotToast.closeAllLoading();
  }

  _reloadFAB() async{
    animation = TypewriterTween(end: _statisticText).animate(controller);
    await controller.reverse().whenComplete(() {
      setState(() {});
    });
    await controller.forward().whenComplete(() {
      setState(() {});
    });
  }

  _loadUI() async{
    await Future.delayed(const Duration(seconds: 1), (){setState(() {
      _isUIVisible = true;
    });});
    await Future.delayed(const Duration(seconds: 1), (){_reloadFAB();});
  }

  @override
  initState(){
    super.initState();
    for (int i = 0; i <= 48; i++) {
      lf.add(LottoField(i + 1, false));
    }
    ShakeDetector sd = ShakeDetector.waitForStart(
        onPhoneShake: () {
          tickFields();
        }
    );
    sd.startListening();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animation = TypewriterTween(end: _statisticText).animate(controller);

    _loadUI();
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

      Map<String, dynamic> _json = jsonDecode(_jsonString);
      var maxRange = 0;
      for(var i = 0; i < _json['lottozahlen'].length; i++){
        maxRange = maxRange + int.parse(_json['lottozahlen'][i]['haeufigkeit']);
      }
      print("Max Range: "+maxRange.toString());
      Random r = new Random();
      for(int i = 0;i < 6;i++){
        var rResult;
        var lz;
        do{
          rResult = r.nextInt(maxRange)+1;
          print("Range-Pick-Result: "+rResult.toString());
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
    });
  }

  setSuperN(){
    Random r = new Random();
    superTC.text = r.nextInt(10).toString();
    vibratePhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: SingleChildScrollView(
          child: AnimatedOpacity(
            opacity: _isUIVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 1500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                LottoFields(lf: lf),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Superzahl",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  width: 50,
                  child:TextField(
                    controller: superTC,
                    textAlign: TextAlign.center,
                    enabled: false,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child:RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    child: Text("pick",style: TextStyle(fontSize: 18)),
                    onPressed: (){
                      setSuperN();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isUIVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 1000),
        child:FloatingActionButton.extended(
          onPressed: _isStatisticsLoaded ? () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Statistics(_jsonString)),
            );
          } : () {
            _callWebservice();
          },
          icon: Icon(_isStatisticsLoaded ? Icons.assignment : Icons.autorenew),
          label: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Text('${animation.value}',
                  style: TextStyle(fontSize: 18));
            },
          ),
          tooltip: _isStatisticsLoaded ? "show statistics" : "import statistics",
        ),
      ),
    );
  }
}
