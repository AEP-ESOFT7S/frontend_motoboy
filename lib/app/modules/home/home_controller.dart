import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  final Location _location = Location();

  final MapController mapController = MapController();

  final accessTokenMapBox =
      'pk.eyJ1Ijoic290b3JpdmEiLCJhIjoiY2tnODFyYXB0MDczdTMxcGYyd21vOGx3cCJ9.LF4RX8YJahP0wLMB9qzxBg';

  final deliveryNotificationIsVisible = false.obs;
  get getDeliveryNotificationIsVisible => deliveryNotificationIsVisible.value;
  set setDeliveryNotificationIsVisible(bool value) => deliveryNotificationIsVisible.value = value;

  @override
  void onInit() async {
    await getUserLocalization();

    super.onInit();
  }

  final _index = 0.obs;
  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;

  final _rotation = 0.0.obs;
  double get getRotation => _rotation.value;
  set setRotation(double value) => _rotation.value = value;

  final _darkModeMap = false.obs;
  bool get getIsDarkModeMap => _darkModeMap.value;
  set setIsDarkModeMap(bool value) => _darkModeMap.value = value;

  final _mapTheme = 'day'.obs;
  String get getMapTheme => _mapTheme.value;
  set setMapTheme(String value) => _mapTheme.value = value;
  void toggleMapTheme() {
    setMapTheme = getMapTheme == 'day' ? 'night' : 'day';
    setIsDarkModeMap = !getIsDarkModeMap;
  }

  final _userLocation = LatLng(0.0, 0.0).obs;
  LatLng get getUserLocation => _userLocation.value;
  set setUserLocation(LatLng value) => _userLocation.value = value;

  Future<void> getUserLocalization() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      await _location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);

      final myLocation = await _location.getLocation();
      setUserLocation = LatLng(myLocation.latitude!, myLocation.longitude!);

      mapController.move(getUserLocation, mapController.zoom);
    } catch (error) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
