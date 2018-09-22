import 'package:flutter/material.dart';
import 'package:wash_x/controller/choicecontroller.dart';
import 'package:wash_x/custom/washbar.dart';
import 'package:wash_x/helpers/washfirebase.dart';
import 'package:wash_x/models/model.dart';
import 'package:scoped_model/scoped_model.dart';
class CustomTimeChange extends StatefulWidget {
  @override
  _CustomTimeChange createState() => new _CustomTimeChange();
}

class _CustomTimeChange extends State<CustomTimeChange> {

  ChoiceController _timeController;
  ChoiceController _dayController;

  List<String> _time = ['MORNING', 'NOON', 'EVENING'];
  List<String> _dayweek = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  static const text = 'Description time change';

  @override
  void initState() {
    super.initState();
    _timeController = new ChoiceController(list: _time,);
    _dayController = new ChoiceController(list: _dayweek,);
  }

  void update(){
    DeliveryTimeModel a = new DeliveryTimeModel(
      weekday: _dayController.item,
      time: _timeController.item
    );
    WashDatabase.updateDeliveryTime(a);
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<WashModel>(
        builder: (context, child, model) {
          _dayController.item = model.delivery.weekday;
          _timeController.item = model.delivery.time;
      return Container(
      margin: new EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
        new Container(
          alignment: Alignment.center,
          child: new Icon(Icons.drag_handle)),
        new Text(text,style: new TextStyle(fontSize: 18.0)),
        new WashBar(controller: _timeController, list: _time,),
        new WashBar(controller: _dayController, list: _dayweek,),
      ]
    ));});
  }

  @override
  void dispose() {
    update();
    super.dispose();
  }
}