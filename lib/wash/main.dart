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

class _MyHomePageState extends State<MyHomePage>{
  WashModel washModel;
  StreamSubscription _subsWash;

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
    _login();
    WashDatabase.getWashModel('', _updateWash)
        .then((StreamSubscription s) => _subsWash = s);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return washModel==null? new Container() : ScopedModel<WashModel>(
      model: washModel,
      child: MaterialApp(
      home: DefaultTabController(
        length: 5,
        initialIndex: 0,
        child: new Scaffold(
          resizeToAvoidBottomPadding: false,
          body:  TabBarView(
            children: <Widget>[
              new Container(child: new Container(child: new Text('ProfilePage'))),
              new Container(child: new BasketPage()),
              new Container(child: new LaundryPage()),
              new Container(child: new DryCleanPage()),
              new Container(child: new Container(child: new Text('ProfilePage')))
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
                  tabCount: 5,
                  width: 250.0),
                width: 250.0,
                height: 48.0,
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicator: new CustomTabIndicator(),
                  tabs: [
                    Tab(icon: Icon(MyFlutterApp.user )),
                    Tab(icon: Icon(MyFlutterApp.trash )),
                    Tab(icon: Icon(MyFlutterApp.local_laundry_service)),
                    Tab(icon: Icon(MyFlutterApp.coatrack)),
                    Tab(icon: Icon(MyFlutterApp.help))
                  ]
                )
              )),
              new SingleChildScrollView(padding: new EdgeInsets.all(8.0),
                scrollDirection: Axis.horizontal,
                child: new Row(children:[
                  ScopedModelDescendant<WashModel>(
                    builder: (context, child, model) {
                      return new WashChip(
                        bottonSheet: new AddressChange(),
                        label: new Text(model.address.line1),
                        avatar: new Icon(MyFlutterApp.place,size: 18.0,));}),
                  new WashChip(
                    bottonSheet: new CustomTimeChange(),
                    label: new Text('time change'),
                    avatar: new Icon(MyFlutterApp.clock,size: 18.0,)),
                  new WashChip(
                      bottonSheet: new AppOptions(),
                      label: new Text('APP OPTIONS'),
                      avatar: new Icon(MyFlutterApp.info,size: 18.0,))

                ]
                ))
                ]
        )))));
  }
}

class ProfilePage {
}

class ChipContent {
  ChipContent({ this.title, this.icon, this.content});
  String title;
  IconData icon;
  Widget content;
}

List<ChipContent> choices = <ChipContent>[
  new ChipContent(
      content: new AddressChange(),
      icon: MyFlutterApp.place),
  new ChipContent(title: 'Tueday/Afternoon', icon: MyFlutterApp.clock,
      content: new CustomTimeChange(), ),
  new ChipContent(title: 'APP OPTIONS',icon: MyFlutterApp.user,
      content: new Text('User\'s options')),
];

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

