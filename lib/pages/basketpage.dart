import 'package:flutter/material.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/laundry/bottonsheet.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPage createState() => _BasketPage();
}

class _BasketPage extends State<BasketPage>
    with AutomaticKeepAliveClientMixin<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            child: new Icon(MyFlutterApp.trash,size: 200.0,)));
  }

  void _showBottomSheet() {
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
