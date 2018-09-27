import 'package:flutter/material.dart';
import 'package:wash_x/models/model.dart';
import 'package:scoped_model/scoped_model.dart';


class WashChip extends StatefulWidget {
  const WashChip({
    this.bottonSheet,
    this.label,
    this.avatar,
//    this.onPressed
  });

  final Widget bottonSheet;
  final Widget avatar;
  final Widget label;

  @override
  _WashChip createState() => new _WashChip();
}

class _WashChip extends State<WashChip> {

//class WashChip extends StatelessWidget {
//  const WashChip({
//    this.bottonSheet,
//    this.label,
//    this.avatar,
//    this.onPressed
//  });

//  final Widget bottonSheet;
//  final Widget avatar;
//  final Widget label;
//  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  new Container(height: 40.0,
      margin: new EdgeInsets.only(right: 1.0),
      child: new Card(elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(const Radius.circular(16.0))),
        child: new ActionChip(
          onPressed: (){
            showModalBottomSheet<Null>(
              context: context,
              builder: (BuildContext context) {
                return widget.bottonSheet;
              }
            );
          },
          label: widget.label,
          padding: new EdgeInsets.all(5.0),
          avatar: widget.avatar)
      )
    );
  }


  _showBottomSheet(Widget content, BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return content;
        }
    );
  }
}

