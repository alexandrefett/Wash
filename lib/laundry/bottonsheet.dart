import 'package:flutter/material.dart';
import 'package:wash_x/helpers/helper.dart';
import 'package:wash_x/models/model.dart';


class BottonSheetBasket extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Column(children: [
      new Container(
        alignment: Alignment.center,
        child: new Icon(Icons.drag_handle)),
      new ListView.builder(itemBuilder:(BuildContext context, int index){
        Clothe item = clothes[index];
        return new ListTile(
          leading: icons[clothes[index].clothe],
          title: new Text('${item.clothe}'),
          trailing: new ActionChip(
            backgroundColor: Colors.lightBlue,
            label: new Text('WASH'),
            onPressed: (){},));})]);
  }
}

