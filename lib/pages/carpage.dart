import 'package:flutter/material.dart';

class CarPage extends StatefulWidget {
  @override
  _CarPage createState() => _CarPage();
}

class _CarPage extends State<CarPage>
    with AutomaticKeepAliveClientMixin<CarPage> {

  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text("Car Wash Page"));
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
