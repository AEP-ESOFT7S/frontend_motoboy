import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlng/latlng.dart';
import 'package:location/location.dart';
import 'package:map/map.dart';
import 'package:verydeli/app/modules/home/home_repository.dart';

class HomeController extends GetxController {
  Location location = Location();

  final HomeRepository _homeRepository = HomeRepository();

  MapController mapController = MapController(location: LatLng(-23.426192, -51.938235));

  final deliveryNotificationIsVisible = false.obs;
  get getDeliveryNotificationIsVisible => deliveryNotificationIsVisible.value;
  set setDeliveryNotificationIsVisible(bool value) => deliveryNotificationIsVisible.value = value;

  final _storage = GetStorage();

  @override
  void onInit() async {
    await getLocation();

    // await _homeRepository.authorization().then((value) {
    //   _storage.write('accessToken', value.result['accessToken']);

    //   Timer.periodic(const Duration(seconds: 30), (Timer t) async {
    //     await _homeRepository.polling(value.result['accessToken']).then((value) {
    //       setDeliveryNotificationIsVisible = true;

    //       Timer(const Duration(seconds: 10), () async {
    //         setDeliveryNotificationIsVisible = false;
    //       });
    //     }).catchError((_) {
    //       ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.toString())));
    //     });
    //   });
    // }).catchError((_) async {
    //   if (_.message != '') {
    //     ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
    //   }
    // });

    super.onInit();
  }

  final _index = 0.obs;

  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;

  final _darkMode = false.obs;

  bool get getIsDarkMode => _darkMode.value;
  set setIsDarkMode(bool value) => _darkMode.value = value;

  final _latitude = 0.0.obs;
  final _longitude = 0.0.obs;
  double get getLatitude => _latitude.value;
  set setLatitude(double value) => _latitude.value = value;
  double get getLongitude => _longitude.value;
  set setLongitude(double value) => _longitude.value = value;
  LatLng get goToDefault => LatLng(-23.426192, -51.938235);

  Future<void> getLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      final myLocation = await location.getLocation();
      setLatitude = myLocation.latitude!;
      setLongitude = myLocation.longitude!;

      // return LatLng(myLocation.latitude!, myLocation.longitude!);
    } catch (error) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('ERRO')));
    }
  }
}
