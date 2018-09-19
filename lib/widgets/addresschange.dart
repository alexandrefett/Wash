import 'package:flutter/material.dart';
import 'package:wash_x/controller/choicecontroller.dart';
import 'package:wash_x/custom/washbar.dart';
import 'package:wash_x/helpers/washfirebase.dart';
import 'package:wash_x/models/model.dart';
import 'package:scoped_model/scoped_model.dart';

class AddressChange extends StatefulWidget {
  @override
  _AddressChange createState() => new _AddressChange();
}

class _AddressChange extends State<AddressChange>{

  List<String> _place = ['HOUSE', 'APARTMENT', 'CONDO'];
  TextEditingController _line1;
  TextEditingController _line2;
  ChoiceController _addressController;
  AddressModel address;

  @override
  void initState() {
    super.initState();
    _line1 = new TextEditingController();
    _line2 = new TextEditingController();
    _addressController = new ChoiceController(list: _place);
  }

  void update(){
    AddressModel a = new AddressModel(
      addresstype: _addressController.item,
      first: _line1.text,
      second: _line2.text);
    print('a:$a');
    WashDatabase.updateAddress(a);
    Navigator.pop(context);
  }

  @override
  void dispose(){
    _line1.dispose();
    _line2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WashModel>(
      builder: (context, child, model) {
        _line1.text = model.address.line1;
        _line2.text = model.address.line2;
        _addressController.item = model.address.addressType;
        return Container(
        margin: new EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
                alignment: Alignment.center,
                child: new Icon(Icons.drag_handle)
            ),
            new Text('ADDRESS & TYPE',
                style: new TextStyle(
                    fontSize: 18.0,
                    color: Colors.blueAccent
                )
            ),
            new WashBar(
              controller: _addressController,
              list: _place
            ),
            new Text('ADDRESS',
              style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.blueAccent
              )
            ),
            new Container(
              margin: new EdgeInsets.only(top: 16.0, bottom: 16.0),
              padding: new EdgeInsets.all(6.0),
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.black12),
                borderRadius: new BorderRadius.all(
                  const Radius.circular(16.0))),
              child: new TextField(
                controller: _line1,
                onChanged: (value) {
                  _line1.text = value;
                  print('value: $value');
                },
                decoration: null)
            ),
            new Container(
                padding: new EdgeInsets.all(6.0),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black12),
                    borderRadius: new BorderRadius.all(
                        const Radius.circular(16.0))),
                child: new TextField(
                  controller: _line2,
                  onChanged: (value) {
                    _line2.text = value;
                  },
                  decoration: null,
                )
            ),
            new Expanded(
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: new Text('CANCEL')),
                      new FlatButton(
                        onPressed: () {
                          update();
                          //Navigator.pop(context);
                        },
                        child: new Text('CONFIRM'))
                    ]
                )
            )
          ]));});
  }
}
