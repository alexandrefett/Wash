import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wash_x/models/model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
  remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));
  return remoteConfig;
}

class WashDatabase{
  // ignore: missing_return
  static Future<StreamSubscription<DocumentSnapshot>> getWashModel(String id,
      void onData(WashModel wash)) async {
    Firestore.instance
        .collection('Accounts')
        .document('CCmGCJcbTLBZJGAorXLf')
        .collection('Account ID')
        .document('jamaX13SHwedIWEbfkUI')
        .snapshots().listen((DocumentSnapshot document){
      DeliveryTimeModel delivery = DeliveryTimeModel.fromMap(document.data['DeliveryTime']);
      AddressModel address = AddressModel.fromMap(document.data['Address']);
      WashModel washModel = new WashModel(
          address: address,
          delivery: delivery);
      onData(washModel);
    });
  }

  static void updateAddress(AddressModel address){
    Map<String, dynamic> map = {
      'Address':address.toJson()
    };
    print('map:$map');
    Firestore.instance
        .collection('Accounts')
        .document('CCmGCJcbTLBZJGAorXLf')
        .collection('Account ID')
        .document('jamaX13SHwedIWEbfkUI')
        .updateData(map).catchError((onValue){
      print('error:$onValue');
    });
  }
  static void updateDeliveryTime(DeliveryTimeModel time){
    Map<String, dynamic> map = {
      'DeliveryTime':time.toJson()
    };
    print('map:$map');
    Firestore.instance
        .collection('Accounts')
        .document('CCmGCJcbTLBZJGAorXLf')
        .collection('Account ID')
        .document('jamaX13SHwedIWEbfkUI')
        .updateData(map).catchError((onValue){
      print('error:$onValue');
    });
  }



}