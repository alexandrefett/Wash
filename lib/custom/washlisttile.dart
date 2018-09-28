import 'package:flutter/material.dart';
import 'package:wash_x/helpers/helper.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';

class WashListTile extends StatefulWidget{
  WashListTile({this.item});
  final BasketItem item;

  @override
  _WashListTile createState() => _WashListTile();
}

class _WashListTile extends State<WashListTile>{

  @override
  Widget build(BuildContext context) {
    //print('context.size=${context.size}');
    return new Card(
      elevation: 5.0,
      margin: new EdgeInsets.all(5.0),
      child: Column(children: <Widget>[
        new ListTile(
            leading: new Icon(icons[widget.item.clothe.clothe]),
            title: new Text(widget.item.clothe.clothe),
            subtitle: new Text('\$${widget.item.clothe.value}'),
            trailing: new Icon(MyFlutterApp.dot_3)
        ),
        new LinearProgressIndicator(value: widget.item.current/100,)
      ]),
    );
  }
}