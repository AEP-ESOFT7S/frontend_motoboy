import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import './home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapController = MapController(location: controller.goToDefault);

    Widget _buildPositionWidget(Offset pos, Color color, [IconData icon = Icons.my_location]) {
      return Positioned(
        left: pos.dx - 24,
        top: pos.dy - 24,
        width: 48,
        height: 48,
        child: GestureDetector(
          child: Icon(icon, color: color, size: 38),
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('${mapController.center.latitude} ${mapController.center.longitude}'),
            ),
          ),
        ),
      );
    }

    Widget _buildMarkerWidget(Offset pos, Color color, [IconData icon = Icons.location_pin]) {
      return Positioned(
        left: pos.dx - 24,
        top: pos.dy - 24,
        width: 48,
        height: 48,
        child: GestureDetector(
          child: Icon(icon, color: color, size: 38),
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('${mapController.center.latitude} ${mapController.center.longitude}'),
            ),
          ),
        ),
      );
    }

    void _onDoubleTap() {
      mapController.zoom += 0.5;
    }

    Offset? dragStart;
    double scaleStart = 1.0;
    void _onScaleStart(ScaleStartDetails details) {
      dragStart = details.focalPoint;
      scaleStart = 1.0;
    }

    void _onScaleUpdate(ScaleUpdateDetails details) {
      final scaleDiff = details.scale - scaleStart;
      scaleStart = details.scale;

      if (scaleDiff > 0) {
        mapController.zoom += 0.02;
      } else if (scaleDiff < 0) {
        mapController.zoom -= 0.02;
      } else {
        final now = details.focalPoint;
        final diff = now - dragStart!;
        dragStart = now;
        mapController.drag(diff.dx, diff.dy);
      }
    }

    // final markers = [LatLng(-23.42911, -51.92686)];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Minha localização',
            onPressed: () => mapController.center = controller.goToDefault,
            icon: const Icon(Icons.my_location),
          ),
          IconButton(
            tooltip: 'Alterar para o modo escuro',
            onPressed: () => controller.setIsDarkMode = !controller.getIsDarkMode,
            icon: const Icon(Icons.wb_sunny),
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MapLayoutBuilder(
              controller: mapController,
              builder: (context, transformer) {
                // final markerPositions = markers.map(transformer.fromLatLngToXYCoords).toList();

                // final markerWidgets = markerPositions.map((pos) => _buildMarkerWidget(pos, Colors.red));

                // final centerLocation = Offset(transformer.constraints.biggest.width / 2,
                //     transformer.constraints.biggest.height / 2);

                // final centerMarkerWidget = _buildMarkerWidget(centerLocation, Colors.purple);

                final mylocal = transformer.fromLatLngToXYCoords(
                  LatLng(controller.getLatitude, controller.getLongitude),
                );

                final myPosition = _buildPositionWidget(mylocal, Colors.red);

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onDoubleTap: _onDoubleTap,
                  onScaleStart: _onScaleStart,
                  onScaleUpdate: _onScaleUpdate,
                  child: Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerSignal: (event) {
                      if (event is PointerScrollEvent) {
                        final delta = event.scrollDelta;

                        mapController.zoom -= delta.dy / 1000.0;
                      }
                    },
                    child: Stack(
                      children: [
                        Map(
                          controller: mapController,
                          builder: (context, x, y, z) {
                            final lightUrl =
                                'https://api.mapbox.com/styles/v1/mapbox/navigation-day-v1/tiles/$z/$x/$y?access_token=pk.eyJ1Ijoic290b3JpdmEiLCJhIjoiY2tnODFyYXB0MDczdTMxcGYyd21vOGx3cCJ9.LF4RX8YJahP0wLMB9qzxBg';

                            final darkUrl =
                                'https://api.mapbox.com/styles/v1/mapbox/navigation-night-v1/tiles/$z/$x/$y?access_token=pk.eyJ1Ijoic290b3JpdmEiLCJhIjoiY2tnODFyYXB0MDczdTMxcGYyd21vOGx3cCJ9.LF4RX8YJahP0wLMB9qzxBg';

                            return Obx(
                              () => CachedNetworkImage(
                                imageUrl: controller.getIsDarkMode ? darkUrl : lightUrl,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                        myPosition,
                        // ...markerWidgets,
                        // centerMarkerWidget,
                      ],
                    ),
                  ),
                );
              },
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
                            Text('Nome do restaurante: '),
                            Text('Distancia: '),
                          ],
                        ),
                        ElevatedButton(onPressed: () {}, child: const Text('Aceitar'))
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
