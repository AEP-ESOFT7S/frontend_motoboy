import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:verydeli/app/modules/home/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  final Location _location = Location();

  final MapController mapController = MapController();

  final accessTokenMapBox =
      'pk.eyJ1Ijoic290b3JpdmEiLCJhIjoiY2tnODFyYXB0MDczdTMxcGYyd21vOGx3cCJ9.LF4RX8YJahP0wLMB9qzxBg';

  final String urlMapBox =
      'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic290b3JpdmEiLCJhIjoiY2tnODFyYXB0MDczdTMxcGYyd21vOGx3cCJ9.LF4RX8YJahP0wLMB9qzxBg';

  final deliveryNotificationIsVisible = true.obs;
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

  final _userLocation = LatLng(0.0, 0.0).obs;
  LatLng get getUserLocation => _userLocation.value;
  set setUserLocation(LatLng value) => _userLocation.value = value;

  final _route = <Marker>[].obs;
  List<Marker> get getRouteMarks => _route;
  set setRouteMarks(List<Marker> value) => _route.value = value;

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

  void getRoute() async {
    String initialRoute = '${getUserLocation.longitude},${getUserLocation.latitude}';
    String finalRoute = '-51.926,-23.43815';
    final result = await _homeRepository.getRoute(initialRoute, finalRoute, accessTokenMapBox);

    for (var element in result.result) {
      _route.add(
        Marker(
          width: 16,
          height: 16,
          point: LatLng(element[1], element[0]),
          rotate: true,
          builder: (BuildContext context) {
            return GestureDetector(
              child: const Icon(Icons.circle, color: Colors.blue, size: 26),
            );
          },
        ),
      );
    }
  }
}
