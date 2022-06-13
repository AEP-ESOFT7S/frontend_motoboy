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
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Minha localização',
            onPressed: () {
              controller.mapController.rotate(0.0);
              controller.mapController.move(
                controller.getUserLocation,
                controller.mapController.zoom,
              );
            },
            icon: const Icon(Icons.my_location),
          ),
          IconButton(
            tooltip: 'Alterar para o modo escuro',
            onPressed: () => controller.toggleMapTheme(),
            icon: Obx(
              () => Icon(controller.getIsDarkModeMap ? Icons.wb_sunny : Icons.brightness_2),
            ),
          ),
        ],
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
        child: Obx(
          () => FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              center: LatLng(-23.426192, -51.938235),
              zoom: 15.0,
              maxZoom: 18,
              minZoom: 1.5,
              rotation: controller.getRotation,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/mapbox/navigation-${controller.getMapTheme}-v1/tiles/{z}/{x}/{y}?access_token=${controller.accessTokenMapBox}',
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 16,
                    height: 16,
                    point: controller.getUserLocation,
                    rotate: true,
                    builder: (BuildContext context) {
                      return GestureDetector(
                        child: const Icon(Icons.navigation, color: Colors.blue, size: 26),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        // Stack(
        //   alignment: Alignment.bottomCenter,
        //   children: [
        //     MapLayoutBuilder(
        //       controller: controller.mapController,
        //       builder: (context, transformer) {
        //         final phoneLocation = controller.buildMarkerLocation(
        //           transformer.fromLatLngToXYCoords(LatLng(
        //             controller.getUserLocationLatitude,
        //             controller.getUserLocationLongitude,
        //           )),
        //           Colors.blue,
        //           Icons.radio_button_checked,
        //         );

        //         return GestureDetector(
        //           behavior: HitTestBehavior.opaque,
        //           onDoubleTap: controller.onDoubleTap,
        //           onScaleStart: controller.onScaleStart,
        //           onScaleUpdate: controller.onScaleUpdate,
        //           child: Listener(
        //             behavior: HitTestBehavior.opaque,
        //             onPointerSignal: (event) {
        //               if (event is PointerScrollEvent) {
        //                 final delta = event.scrollDelta;

        //                 controller.mapController.zoom -= delta.dy / 1000.0;
        //               }
        //             },
        //             child: Stack(
        //               children: [
        //                 Map(
        //                   controller: controller.mapController,
        //                   builder: (context, x, y, z) {

        //                     return Obx(
        //                       () => CachedNetworkImage(
        //                         imageUrl: controller.getIsDarkModeMap ? darkUrl : lightUrl,
        //                         fit: BoxFit.cover,
        //                       ),
        //                     );
        //                   },
        //                 ),
        //                 phoneLocation,
        //               ],
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //     Obx(
        //       () => Visibility(
        //         visible: controller.getDeliveryNotificationIsVisible,
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Container(
        //             color: Colors.white,
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: const [
        //                     Text('Nome do restaurante: '),
        //                     Text('Distancia: '),
        //                   ],
        //                 ),
        //                 ElevatedButton(onPressed: () {}, child: const Text('Aceitar'))
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
