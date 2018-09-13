import 'package:flutter/material.dart';

class SetupScreenWidgets {
  static messageBox(String message, AnimationController controller) {
    return new SizeTransition(
        axis: Axis.vertical,
        sizeFactor:
            new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        axisAlignment: 0.0,
        child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
          margin: const EdgeInsets.symmetric(vertical: 2.5),
          child: new Text(
            message,
            style: TextStyle(fontSize: 11.0),
          ),
        ));
  }

  static messageBoxLarge(String message, AnimationController controller) {
    return new SizeTransition(
        axis: Axis.vertical,
        sizeFactor:
            new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        axisAlignment: 0.0,
        child: new Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          margin: const EdgeInsets.symmetric(vertical: 15.0),
          child: new Text(
            message,
            style: TextStyle(fontSize: 17.0),
          ),
        ));
  }

  static textField(AnimationController controller) {
    return new SizeTransition(
        sizeFactor:
            new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        child: new Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: new TextField(
            decoration: new InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
              prefixIcon: new IconButton(
                onPressed: null,
                icon: new Icon(Icons.blur_circular),
                color: Colors.black,
              ),
              hintStyle: new TextStyle(fontSize: 10.0, color: Colors.grey),
              border: new OutlineInputBorder(
                  gapPadding: 8.0,
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: new BorderSide(color: Colors.grey, width: 10.0)),
            ),
          ),
        ));
  }

  static imageBox(AnimationController controller, String asset) {
    return new SizeTransition(
      sizeFactor:
          new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      child: new Container(
          height: 150.0,
          alignment: AlignmentDirectional.center,
          child: new GestureDetector(
            child: new Container(
              padding: EdgeInsets.all(20.0),
              child: new CircleAvatar(
                  backgroundImage: AssetImage(asset),
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  child: new Container(
                    decoration: new BoxDecoration(
                        border: Border.all(color: Colors.grey[200], width: 1.0),
                        borderRadius: BorderRadius.circular(50.0)),
                  )),
            ),
          )),
    );
  }

  static buttonIcon() {}

  static button() {}
}

class ListPayments extends StatefulWidget {
  final AnimationController controller;
  ListPayments(this.controller);
  @override
  _ListPaymentsState createState() => new _ListPaymentsState(controller);
}

class _ListPaymentsState extends State<ListPayments> {
  _ListPaymentsState(this.controller);
  AnimationController controller;

  @override
  void initState() {
    super.initState();
  }

  var _value = 0;

  _buildPaymentDropDownButton() {
    var dropButton = new DropdownButtonHideUnderline(
      child: new DropdownButton(
        iconSize: 0.0,
        value: _value,
        items: <DropdownMenuItem<int>>[
          new DropdownMenuItem(
            child: new Text(
              'ADD',
              textAlign: TextAlign.right,
              style: new TextStyle(color: Colors.blue),
            ),
            value: 0,
          ),
          new DropdownMenuItem(
            child: new Text(
              'Google Pay',
              style: new TextStyle(color: Colors.blue),
            ),
            value: 1,
          ),
          new DropdownMenuItem(
            child: new Text(
              'Apple Pay',
              style: new TextStyle(color: Colors.blue),
            ),
            value: 2,
          ),
        ],
        onChanged: (int value) {
          setState(() {
            if (value == 0) {
              return;
            }
            _value = value;
          });
        },
      ),
    );
    var dropa = new Container(
      constraints: new BoxConstraints.loose(new Size(100.0, 30.0)),
      height: 30.0,
      width: 100.0,
      padding: EdgeInsets.only(left: 5.0),
      margin:
          EdgeInsets.only(right: MediaQuery.of(context).size.width / 2 - 5.0),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey, width: 1.0)),
      child: new Row(
        children: <Widget>[
          new Icon(
            Icons.add,
            color: Colors.blue,
          ),
          dropButton,
        ],
      ),
    );
    return dropa;
  }

  @override
  Widget build(BuildContext context) {
    return _buildPaymentDropDownButton();
  }
}

class ListWardrobe extends StatefulWidget {
  @override
  _ListWardrobeState createState() => _ListWardrobeState();
}

class _ListWardrobeState extends State<ListWardrobe> {
  List<WardrobeItem> wardrobe = <WardrobeItem>[];

  @override
  void initState() {
    super.initState();
    wardrobe.insert(
        0, new WardrobeItem(new Icon(Icons.ac_unit), "Shirt", false));
    wardrobe.insert(
        0, new WardrobeItem(new Icon(Icons.shopping_cart), "T-Shirt", false));
    wardrobe.insert(
        0, new WardrobeItem(new Icon(Icons.camera), "Dress-Shirt", false));
    wardrobe.insert(
        0, new WardrobeItem(new Icon(Icons.add_shopping_cart), "Jacket", true));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 300.0,
      //color: Colors.yellow,
      child: new ListView.builder(
        itemBuilder: (_, int index) => wardrobe[index],
        itemCount: wardrobe.length,
        reverse: false,
      ),
    );
  }
}

class WardrobeItem extends StatefulWidget {
  WardrobeItem(this._icon, this._item, this._isSelected);
  final Icon _icon;
  final String _item;
  final bool _isSelected;

  @override
  _WardrobeItemState createState() => new _WardrobeItemState(_icon,_item,_isSelected);
}

class _WardrobeItemState extends State<WardrobeItem> {
    _WardrobeItemState(this._icon, this._item, this._isSelected);
  final Icon _icon;
  final String _item;
  final bool _isSelected;
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 2.5),
      height: 40.0,
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 0,
            child: _icon,
          ),
          new Expanded(
            flex: 1,
            child: new Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: new Text(_item),
            ),
          ),
          new Expanded(
            flex: 0,
            child: new CircleAvatar(
              backgroundColor:_isSelected?Colors.blue: Colors.grey,
              child: new Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
