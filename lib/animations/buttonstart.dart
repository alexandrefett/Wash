import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class ButtonAnimation extends StatefulWidget {
  ButtonAnimation({this.child});
  Widget child;
  @override
  _ButtonAnimation createState() => new _ButtonAnimation();
}

class _ButtonAnimation extends State<ButtonAnimation>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animationController.addListener(() {
      setState(() {});
    });
    _animation = Tween(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    print(width);
    print(_animation.value);
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          body: Transform(
            transform:
            Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
          child: new Center(
            child: FlatButton(
              child: new Text('START WASH',
                style: TextStyle(color: Colors.blueAccent)),
              shape: new StadiumBorder(
                side: new BorderSide(color: Colors.black26)),
              onPressed: () {
                _animationController.forward();
              })),
        ));
      });
  }
}
