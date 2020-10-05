import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        primaryColor: Colors.purple,
        buttonColor: Colors.purple,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.purple,
          textTheme: ButtonTextTheme.primary
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple,
        ),
      ),
      home: MyHomePage(title: 'Purple Juice'),
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
                      checkColor: Colors.purple,
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

  bool _isUIVisible = false;

  AnimationController controller;
  Animation<double> animation;

  _loadUI() async{
    await Future.delayed(const Duration(seconds: 1), (){setState(() {
      _isUIVisible = true;
    });});
  }

  @override
  initState(){
    super.initState();

    controller = new AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
    );

    animation = controller;
    for (int i = 0; i <= 48; i++) {
      lf.add(LottoField(i + 1, false));
    }
    ShakeDetector sd = ShakeDetector.waitForStart(
        onPhoneShake: () {
          tickFields();
        }
    );
    sd.startListening();

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

      Random r = new Random();
      int counter = 0;
      do{
        int result = r.nextInt(49);
        if(!lf[result].isTicked()){
          lf[result].setTicked(true);
          counter++;
        }
      }while(counter<6);

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
        centerTitle: true,
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
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Superzahl",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  width: 50,
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child){
                      return TextField(
                        controller: superTC,
                        textAlign: TextAlign.center,
                        enabled: false,
                        style: TextStyle(fontSize: 30),
                      );
                    },
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
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child:RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    child: Text("randomize",style: TextStyle(fontSize: 18)),
                    onPressed: (){
                      tickFields();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
