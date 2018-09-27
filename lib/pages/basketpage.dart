import 'package:flutter/material.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/laundry/bottonsheet.dart';
import 'package:wash_x/animations/buttonstart.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPage createState() => _BasketPage();
}

class _BasketPage extends State<BasketPage>
    with AutomaticKeepAliveClientMixin<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        new Column(children: <Widget>[
          Container(
            child: Icon(MyFlutterApp.trash,size: 275.0),
            padding: new EdgeInsets.only(top:100.0),
          ),
          FlatButton(
            child: new Text('START WASH',
              style: TextStyle(color: Colors.blueAccent)),
            shape: new StadiumBorder(
              side: new BorderSide(color: Colors.black26)),
            onPressed: () {})
        ]),
      ]);
  }

  _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return new BottonSheetBasket();
      });
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
