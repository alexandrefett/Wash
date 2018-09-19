import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {

  static const MARGIN = 4.0;
  static const HEIGTH = 5.0;

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return new _CustomPainter(this, onChanged);
  }
}

class _CustomPainter extends BoxPainter {

  final CustomTabIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);


    Rect rect;
    final Paint paint = Paint();
    double top = configuration.size.height-CustomTabIndicator.HEIGTH;
    double width = configuration.size.width-CustomTabIndicator.MARGIN*2;
    rect = new Rect.fromLTWH(offset.dx+CustomTabIndicator.MARGIN, top, width, CustomTabIndicator.HEIGTH);
    paint.style = PaintingStyle.fill;
    paint.color = Colors.blueAccent;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(5.0)), paint);
  }
}