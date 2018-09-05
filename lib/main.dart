import 'dart:async';
import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:washx/global.dart';

void main() {
  runApp(new MaterialApp(
      title: 'Wash X',
      home: new FutureBuilder<RemoteConfig>(
        future: setupRemoteConfig(),
        builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
          return snapshot.hasData
              ? new WelcomeWidget(remoteConfig: snapshot.data)
              : new Container();
        },
      )));
}

class WelcomeWidget extends AnimatedWidget {
  WelcomeWidget({this.remoteConfig}) : super(listenable: remoteConfig);

  final RemoteConfig remoteConfig;
  int selectedMenuId = -1;

  _onSelectItem(int index) {
    switch (index) {
      case 0:
      case 1:
      case 2:
      case 3:
        break;

      case 4:
        break;
    }
  }




  @override
  Widget build(BuildContext context) {
    // list of Widgets
    List<Widget> drawerOptions = new List();
    //Main Header
    Widget mainHeader = Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 18.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            decoration: new BoxDecoration(
              color: Colors.black12,
              borderRadius: new BorderRadius.all(new Radius.circular(11.0)),
              border: new Border.all(color: Colors.black12, width: 0.0),
            ),
            height: 6.0,
            width: 30.0,
          ),
          Row(
            children: <Widget>[
              Image.asset(
                AppKeyword.ic_user,
                height: 36.0,
                width: 36.0,
              ),
              Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        'Mendy Marcus',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                      ),
                      new Text(
                        'mendymarcus@gmail.com',
                        style: TextStyle(color: Colors.black87, fontSize: 12.0),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(left: 36.0),
                child: new Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.black87, fontSize: 14.0),
                ),
              )
            ],
          )
        ],
      ),
    );
    drawerOptions.add(mainHeader);

    //Option Menu
    String strUserOptionMenu =
        remoteConfig.getString(AppKeyword.ITEM_USER_OPTION_MENU);

    if (strUserOptionMenu != null && strUserOptionMenu.isNotEmpty) {
      var data = json.decode(strUserOptionMenu);

      for (var userMenuData in data) {
        String strMenuTitle =
            userMenuData[AppKeyword.KEY_MENU_TITLE].toString();

        String strMenuImage =
            userMenuData[AppKeyword.KEY_MENU_IMAGE].toString();

        bool strMenuIsActive = userMenuData[AppKeyword.KEY_IS_ACTIVE];

        int strMenuId = userMenuData[AppKeyword.KEY_MENU_ID];

        Widget listItem = InkResponse(
//          onTap: () => _onSelectItem(i),
            onTap: () {
              Global.showCallDialogM(context, strMenuTitle.trim());
            },
            highlightShape: BoxShape.rectangle,
            radius: 0.0,
            child: Container(
              height: 38.0,

              padding: EdgeInsets.only(
                left: 12.0,
                top: 7.0,
                bottom: 7.0,
                right: 7.0,
              ),
//            color: i == _selectedDrawerIndex ? AppColors.colorSemiTrans : null,
              child: Row(
                children: <Widget>[
                  Image.network(
                    strMenuImage,
                    color: Colors.black87,
                    height: 20.0,
                    width: 20.0,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 15.0),
                      child: new Text(
                        strMenuTitle,
                        style: TextStyle(color: Colors.black87, fontSize: 14.0),
                      ))
                ],
              ),
            ));

        if (strMenuIsActive) {
          drawerOptions.add(listItem);
        }
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Wash X'),
      ),

//      body: new Center(
//          child: new Text('Welcome ${remoteConfig.getString('welcome')}')),
//      floatingActionButton: new FloatingActionButton(
//          child: const Icon(Icons.refresh),
//          onPressed: () async {
//            try {
//              // Using default duration to force fetching from remote server.
//              await remoteConfig.fetch(expiration: const Duration(seconds: 0));
//              await remoteConfig.activateFetched();
//            } on FetchThrottledException catch (exception) {
//              // Fetch throttled.
//              print(exception);
//            } catch (exception) {
//              print(
//                  'Unable to fetch remote config. Cached or default values will be '
//                      'used');
//            }
//          }),
//      body: new Column(children: drawerOptions),
      body: new Center(
          child: new RaisedButton(
              child: const Text('USER OPATIONS'),

              onPressed: () async {
                try {
                  // Using default duration to force fetching from remote server.
                  await remoteConfig.fetch(expiration: const Duration(seconds: 0));
                  await remoteConfig.activateFetched();
                } on FetchThrottledException catch (exception) {
                  // Fetch throttled.
                  print(exception);
                } catch (exception) {
                  print(
                      'Unable to fetch remote config. Cached or default values will be '
                          'used');
                }

                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return new Container(
                          child: new Padding(
                            padding:
                            const EdgeInsets.only(left: 32.0, right: 15.0),
                            child: new Column(children: drawerOptions),
                          ),
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                topRight: new Radius.circular(11.0),
                                topLeft: new Radius.circular(11.0)),
                            border: new Border.all(
                              color: Colors.black12,
                              width: 1.8,
                            ),
                          ));
                    });
              },

//              onPressed: () {
////                refresh(remoteConfig);
//
//
//                showModalBottomSheet<void>(
//                    context: context,
//                    builder: (BuildContext context) {
//                      return new Container(
//                          child: new Padding(
//                            padding:
//                                const EdgeInsets.only(left: 32.0, right: 15.0),
//                            child: new Column(children: drawerOptions),
//                          ),
//                          decoration: new BoxDecoration(
//                            borderRadius: new BorderRadius.only(
//                                topRight: new Radius.circular(11.0),
//                                topLeft: new Radius.circular(11.0)),
//                            border: new Border.all(
//                              color: Colors.black12,
//                              width: 1.8,
//                            ),
//                          ));
//                    });
//              }

              )),
    );
  }
}

refresh(remoteConfig) async {

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print(
          'Unable to fetch remote config. Cached or default values will be '
              'used');
    }

}

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
  remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));
  remoteConfig.setDefaults(<String, dynamic>{
    'welcome': 'default welcome',
    'hello': 'default hello',
  });
  return remoteConfig;
}
