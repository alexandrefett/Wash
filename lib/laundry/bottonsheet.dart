import 'package:flutter/material.dart';
import 'package:wash_x/helpers/helper.dart';
import 'package:wash_x/models/model.dart';

class BottonSheetBasket extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.center,
        child: new Icon(Icons.drag_handle)),
      Expanded(
        child: new ListView.builder(
            itemCount: clothes.length,
            itemBuilder:(BuildContext context, int index){
          Clothe item = clothes[index];
          return new ListTile(
            leading: Icon(icons[clothes[index].clothe]),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
              new Text('${item.clothe}',),
              new Text('${item.value}',)
            ],),
            trailing: Row(children: <Widget>[
              IconButton(
                icon: Icon(Icons.create),
                iconSize: 22.0,
                color: Colors.blueAccent,disabledColor: Colors.blueAccent,
              ),
              ActionChip(
                  backgroundColor: Colors.blueAccent,
                  label: new Text('WASH',
                    style: new TextStyle(color: Colors.white)),
                  onPressed: (){})
            ],)
          );
        }
      ))
    ]
    );
  }
}

