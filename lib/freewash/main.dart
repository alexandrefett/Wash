import 'package:flutter/material.dart';
import 'package:wash_x/freewash/ui/free-wash.dart';
//import 'package:washx/ui/free-wash.dart';

void main() => runApp(new MaterialApp(
      title: 'Wash X',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new FreeWash(),
    ));
