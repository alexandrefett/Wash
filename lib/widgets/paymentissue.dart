import 'package:flutter/material.dart';
import 'package:wash_x/models/model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wash_x/controller/choicecontroller.dart';
import 'package:wash_x/custom/washbar.dart';
import 'package:wash_x/helpers/washfirebase.dart';

class PaymentIssue extends StatefulWidget {
  @override
  _PaymentIssue createState() => new _PaymentIssue();
}

class _PaymentIssue extends State<PaymentIssue> {


  static const text = 'Your payment didn\'t go trough';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WashModel>(
      builder: (context, child, model) {
      return new Container(
      margin: new EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
        new Container(
          alignment: Alignment.center,
          child: new Icon(Icons.drag_handle)),
        new Text(text,style: new TextStyle(fontSize: 16.0)),
        FlatButton(
            child: new Text('PAY',
                style: TextStyle(color: Colors.blueAccent)),
            shape: new StadiumBorder(
                side: new BorderSide(color: Colors.black26)),
            onPressed: () {})
      ]));
      });
  }

  @override
  void dispose() {
    super.dispose();
  }
}