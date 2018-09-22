import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wash_x/custom/chipbase.dart';
import 'package:wash_x/custom/custom_tab_bar.dart';
import 'package:wash_x/custom/custom_tab_bar_incative.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/helpers/washfirebase.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/pages/drycleanpage.dart';
import 'package:wash_x/pages/laundrypage.dart';
import 'package:wash_x/pages/basketpage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wash_x/widgets/addresschange.dart';
import 'package:wash_x/widgets/appoptions.dart';
import 'package:wash_x/widgets/timechange.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'washx',
      theme: _washTheme,
      home: new MyHomePage(title: 'washx'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin{
  WashModel washModel;
  StreamSubscription _subsWash;
  TabController _tabcontroller;
  String _currentTab;

  void _login() async{
    FirebaseUser user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: 'alexandrefett@gmail.com',
        password: 'tuneca2011');
  }

  _updateWash(WashModel value){
    setState(() {
      washModel = value;
    });
  }

@override
  void dispose() {
    if(_subsWash!=null)
      _subsWash.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabcontroller = new TabController(vsync: this, length: pages.length);
    _tabcontroller.addListener((){
      setState(() {
        _currentTab = pages[_tabcontroller.index];
      });
    });
    _currentTab = pages[_tabcontroller.index];
    _login();
    WashDatabase.getWashModel('', _updateWash)
        .then((StreamSubscription s) => _subsWash = s);
  }

  @override
  Widget build(BuildContext context) {
    return washModel==null? new Container() : ScopedModel<WashModel>(
      model: washModel,
      child: MaterialApp(
      home: new Scaffold(
          resizeToAvoidBottomPadding: false,
          body:  TabBarView(controller: _tabcontroller,
            children: <Widget>[
              new Container(child: new BasketPage()),
              new Container(child: new LaundryPage()),
              new Container(child: new DryCleanPage()),
              new Container(child: new Center(child: new Text('Car Wash'))),
              new Container(child: new Center(child: new Text('Couch Wash'))),
        ]),
        bottomNavigationBar: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            PreferredSize(
              preferredSize: Size(250.0, 48.0),
              child: new Container(
                margin: new EdgeInsets.all(5.0),
                decoration: new CustomTabInactive(
                  tabCount: pages.length,
                  width: 250.0),
                width: 250.0,
                height: 48.0,
                child: TabBar(controller: _tabcontroller,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicator: new CustomTabIndicator(),
                  tabs: [
                    Tab(icon: Icon(MyFlutterApp.trash )),
                    Tab(icon: Icon(MyFlutterApp.local_laundry_service)),
                    Tab(icon: Icon(MyFlutterApp.coatrack)),
                    Tab(icon: Icon(Icons.local_car_wash)),
                    Tab(icon: Icon(Icons.local_car_wash)),
                  ]))),
            Column(children: <Widget>[
            ScopedModelDescendant<WashModel>(
              builder: (context, child, model) {
                return new SingleChildScrollView(
                  padding: new EdgeInsets.all(8.0),
                  scrollDirection: Axis.horizontal,
                  child: new Row(children:[
                    new WashChip(
                      bottonSheet: new AddressChange(),
                      label: new Text(model.address.line1),
                      avatar: new Icon(MyFlutterApp.place,size: 18.0,)),
                    new WashChip(
                      bottonSheet: new CustomTimeChange(),
                      label: new Text('${model.delivery.weekday}/${model.delivery.time}'),
                      avatar: new Icon(MyFlutterApp.clock,size: 18.0,)),
                    new WashChip(
                      bottonSheet: new AppOptions(),
                      label: new Text('APP OPTIONS'),
                      avatar: new Icon(MyFlutterApp.info,size: 18.0,))
              ]));}),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max ,
                children: <Widget>[
                  new Container(
                      padding: new EdgeInsets.all(5.0),
                      child: FloatingActionButton(
                        child: new Image.asset('assets/assistant.png',width: 25.0,height: 25.0,),
                        backgroundColor: Colors.white,onPressed: (){})),
                  new Text(_currentTab,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold)),
                  new IconButton(icon: new Icon(Icons.tune,size: 30.0,))
                ])
              ])
            ]))));
  }
}

List<String> pages = ['BASKET','WASH', 'WARDROBE','CAR WASH', 'COUCH WASH'];

final ThemeData _washTheme = _buildWashTheme();

ThemeData _buildWashTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      accentColor: Colors.blueAccent,
      primaryColor: Colors.blue,
      buttonColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white10,
      chipTheme: base.chipTheme.copyWith(
        selectedColor: Colors.blueAccent,
        backgroundColor: Colors.white10,
        labelStyle: new TextStyle(color: Colors.blueAccent),
        disabledColor: Colors.white10,
        secondarySelectedColor: Colors.blueAccent,
      )
  );
}

