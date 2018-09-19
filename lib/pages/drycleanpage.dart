import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';

class DryCleanPage extends StatefulWidget {
  @override
  _DryCleanPage createState() => _DryCleanPage();
}

class _DryCleanPage extends State<DryCleanPage>
    with AutomaticKeepAliveClientMixin<DryCleanPage> {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            child: Icon(MyFlutterApp.coatrack, size: 200.0,)));
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
