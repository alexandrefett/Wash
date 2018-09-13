import 'dart:async';

import 'package:wash_x/constants.dart';
import 'package:wash_x/pages/beforeSetupPage.dart';
import 'package:wash_x/widgets/setupScreenWidgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SetupPage extends StatefulWidget {

final _SetupPageState _setupPageState = new _SetupPageState();
void startAnim(){
_setupPageState.startTime();
}

  @override
  _SetupPageState createState() => _setupPageState;
}

class _SetupPageState extends State<SetupPage>
    with TickerProviderStateMixin {
  List<Widget> _itemCards = <Widget>[];
  var _imageFile;
  TextEditingController _addressController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
  //  startTime();
    super.initState();
  }


  void startTime() async {
    Future.delayed(
      const Duration(seconds: 1),
      () => _cardMessageBoxLarge(Constants.setupLetsSetupMsg),
    );
    Future.delayed(
      const Duration(seconds: 1, milliseconds: 800),
      () => _cardImageBox(),
    );
    Future.delayed(
      const Duration(seconds: 1, milliseconds: 1600),
      () => _cardMessageBox(Constants.setupBeforeWeStartMsg),
    );
    Future.delayed(
      const Duration(seconds: 1, milliseconds: 2400),
      () => _cardProfileImageAdd(),
    );
    Future.delayed(
      const Duration(seconds: 1, milliseconds: 2400),
      () => _cardMessageBox(Constants.setupLetsStartMsg),
    );
  }

  void _addProfilePicture() {
    debugPrint("Profile picture added");
    _buildBottomSheet();
  }

  //UI building --Start
  FocusNode _focusnode = new FocusNode();
  bool _isFirstLoad = true;
  @override
  Widget build(BuildContext context) {
    if (_isFirstLoad) {
      _itemCards.insert(
          0,
          new Container(
            height: MediaQuery.of(context).size.height,
          ));
      _isFirstLoad = false;
    }
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_focusnode);
          },
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Flexible(
                flex: 5,
                child: _buildTopView(),
              ),
              new Flexible(
                flex: 18,
                child: new Stack(
                  children: <Widget>[
                    _buildMainList(),
                    new Positioned(
                      right: 5.0, bottom: 5.0,
                      child: _buildAssistantRow(),
                
                    )
                  ],
                ),
              ),
              new Divider(
                height: 1.5,
                color: Colors.grey,
              ),
              new Flexible(
                flex: 2,
                child: _buildBottomRow(),
              )
            ],
          ),
        ));
  }

//List Elements --start
Future<bool> _onWardrobeAdd()async{
  debugPrint("wardrobe added");
  _itemCards.insert(0, new ListWardrobe() );
  setState(() {  
    });
return true;
}

  Future<bool> _onSubmitAddress(String address) async {
    debugPrint("Address submitted" + address);
    var controller = _buildNewAnimationController();
    await _cardMessageBoxLarge(Constants.setupPaymentMethod);
var controllera = _buildNewAnimationController();
    _itemCards.insert(0, new ListPayments(controllera));
    setState(() {
        });
    await _cardMessageBoxLarge(Constants.setupWardrobe);
    _itemCards.insert(
        0,
        new Container(
          height: MediaQuery.of(context).size.height / 4,
        ));
    Future.delayed(Duration(milliseconds: 500), () => controller.dispose());
    return true;
  }

  _addressField(AnimationController controller) {
    return new SizeTransition(
        sizeFactor:
            new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        child: new Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: new TextField(
            onSubmitted: (String x) async => await _onSubmitAddress(x),
            controller: _addressController,
            decoration: new InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
              prefixIcon: new IconButton(
                onPressed: null,
                icon: new Icon(Icons.blur_circular),
                color: Colors.black,
              ),
              labelText: "ADDRESS",
              labelStyle: new TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
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

  AnimationController _buildNewAnimationController() {
    var controller = new AnimationController(
      duration: new Duration(milliseconds: 500),
      vsync: this,
    );
    return controller;
  }

  Future<bool> _cardMessageBox(String message) async {
    var controller = _buildNewAnimationController();
    controller.forward();
    _itemCards.insert(0, SetupScreenWidgets.messageBox(message, controller));
    setState(() {});
    Future.delayed(Duration(milliseconds: 500), () => controller.dispose());
    return true;
  }

  Future<bool> _cardMessageBoxLarge(String message) async {
    var controller = _buildNewAnimationController();
    controller.forward();
    _itemCards.insert(
        0, SetupScreenWidgets.messageBoxLarge(message, controller));
    setState(() {});
    Future.delayed(Duration(milliseconds: 500), () => controller.dispose());
    return true;
  }

  Future<bool> _cardTextFieldBox() async {
    var controller = _buildNewAnimationController();
    controller.forward();
    _itemCards.insert(0, _addressField(controller));
    setState(() {});
    Future.delayed(Duration(milliseconds: 500), () => controller.dispose());
     Future.delayed(Duration(milliseconds: 600),(){
       _itemCards.insert(0, new Container(
      height: MediaQuery.of(context).size.height / 3,
    ));
    setState(() {
          
        });
     });
    setState(() { });
    return true;
  }

  Future<bool> _cardImageBox() async {
    var controller = _buildNewAnimationController();
    controller.forward();
    _itemCards.insert(0,
        SetupScreenWidgets.imageBox(controller, "assets/assistant_large.png"));
    setState(() {});
    Future.delayed(Duration(milliseconds: 500), () => controller.dispose());
    return true;
  }

  _cardProfileImage() {
    return new Container(
      height: 150.0,
      alignment: AlignmentDirectional.center,
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      child: new CircleAvatar(
        backgroundImage: _imageFile == null
            ? AssetImage("assets/assistant_large.png")
            : FileImage(_imageFile),
        backgroundColor: Colors.white,
        radius: 50.0,
        child: new Container(
          decoration: new BoxDecoration(
              border: Border.all(color: Colors.grey[200], width: 1.0),
              borderRadius: BorderRadius.circular(50.0)),
        ),
      ),
    );
  }

  Future<bool> _cardProfileImageAdd() async {
    var controller = _buildNewAnimationController();
    controller.forward();
    _itemCards.insert(0, _imageProfile(controller));
    setState(() {});
    Future.delayed(Duration(milliseconds: 500), () => controller.dispose());
    return true;
  }

  _imageProfile(AnimationController controller) {
    return new SizeTransition(
      sizeFactor:
          new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      child: new Container(
          height: 150.0,
          alignment: AlignmentDirectional.center,
          child: new GestureDetector(
            onTap: _addProfilePicture,
            child: new Stack(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new CircleAvatar(
                      backgroundImage: _imageFile == null
                          ? AssetImage("assets/assistant_large.png")
                          : FileImage(_imageFile),
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: new Container(
                        decoration: new BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[200], width: 1.0),
                            borderRadius: BorderRadius.circular(50.0)),
                      )),
                ),
                new Positioned(
                  left: 95.0,
                  top: 80.0,
                  child: new Container(
                    width: 30.0,
                    height: 30.0,
                    child: new Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[200], width: 1.0),
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                )
              ],
            ),
          )),
    );
  }

//List Elements --end

//BottomSheet --start

  RaisedButton _createButton(VoidCallback callback, String text) {
    var button = new RaisedButton(
      elevation: 12.0,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.blue,
      onPressed: callback,
      textColor: Colors.white,
      child: new Text(text),
    );
    return button;
  }

  Future _changePicture(bool isCamera) async {
    _imageFile = await ImagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    var pos = _itemCards.length - 5;
    _itemCards.removeAt(pos);
    _itemCards.insert(pos, _cardProfileImage());
    setState(() {});
    Navigator.pop(context);
    _cardMessageBoxLarge(Constants.setupLetsSetupMsg);
    Future.delayed(Duration(milliseconds: 500), () => _cardTextFieldBox());
  }

  _buildBottomSheet() {
    var btnNewPicture = _createButton(
        () async => await _changePicture(true), "Click a new Picture");
    var btnFromGallery = _createButton(
        () async => await _changePicture(false), "Pick From Gallery");

    var button = new RaisedButton(
      elevation: 12.0,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.blue,
      onPressed: () {},
      textColor: Colors.white,
      child: new Text("Click a new picture"),
    );
    button.onPressed();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height / 3,
            color: Colors.white,
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  btnNewPicture,
                  btnFromGallery,
                ],
              ),
            ),
          );
        });
  }

  _buildMainList() {
    return new Container(
        color: Colors.white,
        child: new ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, int index) => _itemCards[index],
          itemCount: _itemCards.length,
          padding: EdgeInsets.only(bottom: 30.0, left: 35.0, right: 35.0),
          reverse: true,
        ));
  }

  _buildTopView() {
    return new Column(
      children: <Widget>[
        new Flexible(
          flex: 3,
          child: Container(
            margin: EdgeInsets.only(left: 30.0, top: 25.0),
            width: MediaQuery.of(context).size.width,
            child: new Text(
              "Welcome",
              textAlign: TextAlign.left,
              style:
                  new TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
            ),
          ),
        ),
        new Flexible(
          flex: 5,
          child: Container(
            height: 60.0,
            margin: EdgeInsets.only(left: 60.0, bottom: 10.0, top: 15.0),
            width: MediaQuery.of(context).size.width,
            child: new Row(
              children: <Widget>[
                new CircleAvatar(
                  radius: 25.0,
                  backgroundImage: _imageFile == null
                      ? AssetImage("assets/assistant.png")
                      : FileImage(_imageFile),
                  backgroundColor: Colors.white,
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: new Text(
                    "Joan Wike",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildAssistant() {
    return new CircleAvatar(
      backgroundColor: Colors.white,
      child: new Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(new Radius.circular(50.0)),
          border: new Border.all(
            width: 1.0,
            color: Colors.grey,
          ),
        ),
      ),
      backgroundImage: new AssetImage(
        'assets/assistant.png',
      ),
    );
  }

  _buildAssistantRow() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Container(
          height: 25.0,
          padding: EdgeInsets.only(right: 10.0),
          child: new FlatButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: Colors.grey)),
            child: new Text(
              "SKIP",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              debugPrint("skip");
             _onWardrobeAdd();
            },
          ),
        ),
        new Container(
          color: Colors.transparent,
          width: 25.0,
          height: 25.0,
          child: new InkWell(
            onTap: () {
              debugPrint("main assistant");
              BeforeSetupPageState.closeTranslateWindow();
            },
            child: _buildAssistant(),
          ),
        ),
        new Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 5.0,
          ),
          child: new Container(
            color: Colors.transparent,
            width: 25.0,
            height: 25.0,
            child: new InkWell(
              onTap: () {
                debugPrint("side kick");
                _cardImageBox();
              },
              child: _buildAssistant(),
            ),
          ),
        ),
      ],
    );
  }

  _buildBottomRow() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new IconButton(
            onPressed: () => BeforeSetupPageState.closeTranslateWindow(),
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        new Expanded(
          flex: 5,
          child: new Text(
            "ASSISTANT",
            textAlign: TextAlign.center,
            style: new TextStyle(color: Colors.blue),
          ),
        ),
        new Expanded(flex: 1, child: new Container()),
      ],
    );
  }
  //UI building --end
}
