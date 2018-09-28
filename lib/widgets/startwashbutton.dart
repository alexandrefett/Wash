import 'package:flutter/material.dart';

class StartWashButton extends StatelessWidget{
  StartWashButton({this.onPressed});
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
        child: new Text('START WASH',
            style: TextStyle(color: Colors.blueAccent)),
        shape: new StadiumBorder(
            side: new BorderSide(color: Colors.black26)),
        onPressed: onPressed);
  }


}