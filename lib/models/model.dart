import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class WashModel extends Model{
  WashModel({this.delivery, this.address});

  AddressModel address;
  DeliveryTimeModel delivery;

  AddressModel get deliveryAddress => address;
  DeliveryTimeModel get deliveryTime => delivery;


  List<BasketItem> _items = [];
  List<BasketItem> get items => _items;

  List<WashRemoteItem> _configs = [];
  List<WashRemoteItem> get configs => _configs;

  void add(BasketItem item){
    _items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearBasket(){
    _items.clear();
    notifyListeners();
  }

  void set configs(value){
    _configs = value;
    notifyListeners();
  }

  void clearConfig(){
    _configs.clear();
    notifyListeners();
  }

  void addItem(WashRemoteItem item){
    _configs.add(item);
    notifyListeners();
  }
}

class WashRemoteItem extends Model{
  String menu_title;
  String menu_image;
  bool is_active;
  int menu_id;

  WashRemoteItem({
    this.menu_title,
    this.menu_image,
    this.is_active,
    this.menu_id});

  factory WashRemoteItem.fromMap(Map<String, dynamic> map){
    return new WashRemoteItem(
      is_active: map['is_active'],
      menu_id: map['manu_id'],
      menu_image: map['menu_image'],
      menu_title: map['menu_title']
    );
  }
}

class DeliveryTimeModel extends Model {
  DeliveryTimeModel({this.time, this.weekday});

  String time;
  String weekday;

  factory DeliveryTimeModel.fromMap(Map<dynamic, dynamic> map){
    return new DeliveryTimeModel(
        time: map['time'],
        weekday: map['weekday']
    );
  }

  Map<String, dynamic> toJson() => {
    'time':time,
    'weekday':weekday
  };
}

class AddressModel extends Model{
  AddressModel({this.first, this.second,this.addresstype});

  String addresstype;
  String first;
  String second;

  factory AddressModel.fromMap(Map<dynamic, dynamic> map){
    return new AddressModel(
      first:map['line1'],
      second:map['line2'],
      addresstype:map['type']);
  }

  Map<String, dynamic> toJson() => {
    'line1': first,
    'line2': second,
    'type': addresstype
  };

  String get line1 => first;
  set line1(String value) {
    first = value;
    notifyListeners();
  }

  String get line2 => second;
  set line2(String value) {
    second = value;
    notifyListeners();
  }

  String get addressType => addresstype;
  set addressType(String value){
    addresstype = value;
    notifyListeners();
  }
  static AddressModel of(BuildContext context) =>
    ScopedModel.of<AddressModel>(context);
}

class BasketModel extends Model{

  static BasketModel of(BuildContext context) =>
      ScopedModel.of<BasketModel>(context);

  List<BasketItem> _items = [];
  List<BasketItem> get items => items;

  void add(BasketItem item){
    _items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear(){
    _items.clear();
    notifyListeners();
  }
}

class WashType extends Model {
  WashType({this.wash,this.dry,this.fold});
  String wash;
  String dry;
  String fold;
}

class Clothe extends Model{
  Clothe({ this.clothe, this.white, this.value});
  String clothe;
  double value;
  bool white;
}

class BasketItem extends Model{
  BasketItem({this.clothe, this.current})
    :quantity = 1;
  Clothe clothe;
  double current;
  int quantity;

  void addItems(int value){
    quantity += value;
    notifyListeners();
  }
}
