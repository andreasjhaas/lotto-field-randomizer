import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

class Statistics extends StatelessWidget {

  Statistics(this.jsonString);
  final String jsonString;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statistics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightGreen,
        buttonColor: Colors.lightGreen,
      ),
      home: Page(title: 'Statistics',jsonString: jsonString),
    );
  }
}

class Page extends StatefulWidget {
  Page({Key key, this.title, this.jsonString}) : super(key: key);

  final String title;
  final String jsonString;

  @override
  _PageState createState() => _PageState(jsonString);
}

class _PageState extends State<Page> {

  String _jsonString;
  static List<LottoNumberModel> initialListData = [];

  _PageState(this._jsonString);

  _loadStatistics() async{
    Map<String, dynamic> _json = jsonDecode(_jsonString);
    for(var i = 0; i < _json['lottozahlen'].length;i++){
      await Future.delayed(const Duration(milliseconds: 50), (){setState(() {
        addLottoNumber(_json['lottozahlen'][i]['zahl'],_json['lottozahlen'][i]['haeufigkeit']);
      });});
    }
  }

  @override
  initState() {
    super.initState();
    initialListData = [];
    _loadStatistics();

  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final listData = initialListData;

  void addLottoNumber(var number,var frequency) {
    setState(() {
      int index = listData.length;
      listData.add(
        LottoNumberModel(number: number, frequency: frequency),
      );
      _listKey.currentState
          .insertItem(index, duration: Duration(milliseconds: 300));
    });
  }

  void deleteUser(int index) {
    setState(() {
      var user = listData.removeAt(index);
      _listKey.currentState.removeItem(
        index,
            (context, animation) {
          return FadeTransition(
            opacity:
            CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
            child: SizeTransition(
              sizeFactor:
              CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
              axisAlignment: 0.0,
              child: _buildItem(user),
            ),
          );
        },
        duration: Duration(milliseconds: 600),
      );
    });
  }

  Widget _buildItem(LottoNumberModel user, [int index]) {
    return ListTile(
      key: ValueKey<LottoNumberModel>(user),
      title: Text("Number: "+user.number),
      subtitle: Text("Frequency: "+user.frequency),
      //onLongPress: () => deleteUser(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: AnimatedList(
          key: _listKey,
          initialItemCount: initialListData.length,
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: _buildItem(listData[index], index),
            );
          },
        ),
      ),
    );
  }
}

class LottoNumberModel {
  const LottoNumberModel({this.number, this.frequency});

  final String number;
  final String frequency;
}