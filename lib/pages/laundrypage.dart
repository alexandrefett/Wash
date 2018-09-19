import 'package:flutter/material.dart';
import 'package:wash_x/widgets/wash.dart';
import 'package:wash_x/custom/custom_listtile.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'dart:math' as math;
import 'package:scoped_model/scoped_model.dart';

class LaundryPage extends StatefulWidget {
  @override
  _LaundryPage createState() => _LaundryPage();
}

class _LaundryPage extends State<LaundryPage>
    with AutomaticKeepAliveClientMixin<LaundryPage> {
  final math.Random _rng = new math.Random();
  //List<BasketItem> basket = [];

  _addItem(WashModel model, Clothe item) {
    setState(() {
      model.add(new BasketItem(clothe: item, current: _rng.nextDouble()*300));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WashModel>(
      builder: (context, child, model) {
        return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Expanded(
            child: new ListView.builder(
              cacheExtent: 0.0,
              itemCount: model.items.length,
              itemBuilder: (context, int index) {
                BasketItem item = model.items[index];
                return new CustomListTile(item: item);
              }
            )
          ),
          new GestureDetector(
            onTap: _showBottomSheet,
            child: new Container(
              child: new Icon(
                MyFlutterApp.local_laundry_service,
                color: Colors.blue,size: 150.0,
              )
            )
          ),
          new Container(
            height: 50.0,
            child: new Center(
                child: new Text('Tap to start laundry')
            )
          )
        ]);
      });
    }


  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return new CustomWash();
      });
  }


  @override
  bool get wantKeepAlive => true;
}