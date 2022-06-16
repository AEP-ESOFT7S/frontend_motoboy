import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.my_location),
        onPressed: () {
          controller.mapController.rotate(0.0);
          controller.mapController.moveAndRotate(controller.getUserLocation, 18, 0.0);
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(title: const Text('Configurações'), onTap: () => Get.toNamed('/settings')),
            ListTile(title: const Text('Logout'), onTap: () => Get.offAllNamed('/login')),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Obx(
          () => BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.delivery_dining), label: 'Entregas'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Conta'),
            ],
            currentIndex: controller.getCurrentIndex,
            onTap: (menu) {
              controller.setCurrentIndex = menu;

              if (controller.getCurrentIndex == 0) {
                Get.offAllNamed('/home');
              } else if (controller.getCurrentIndex == 1) {
                Get.offAllNamed('/account');
              }
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Obx(
              () => FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                  center: LatLng(-23.426192, -51.938235),
                  zoom: 15.0,
                  maxZoom: 18,
                  minZoom: 1.5,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: controller.urlMapBox,
                  ),
                  MarkerLayerOptions(
                    markers: controller.getRouteMarks.isNotEmpty
                        ? controller.getRouteMarks
                        : [
                            Marker(
                              width: 16,
                              height: 16,
                              point: controller.getUserLocation,
                              rotate: true,
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  child: const Icon(Icons.navigation, color: Colors.blue, size: 16),
                                );
                              },
                            )
                          ],
                  ),
                ],
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.getDeliveryNotificationIsVisible,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Nome do restaurante: Meu Chefe'),
                            Text('Distancia: 3 Km'),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.setDeliveryNotificationIsVisible = false;
                            controller.getRoute();
                          },
                          child: const Text('Aceitar'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
