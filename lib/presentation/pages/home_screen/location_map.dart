import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../application/location_map_controller.dart';

class YandexLocationMapPage extends StatefulWidget {
  const YandexLocationMapPage({Key? key}) : super(key: key);

  @override
  State<YandexLocationMapPage> createState() => _YandexLocationMapPageState();
}

class _YandexLocationMapPageState extends State<YandexLocationMapPage> {
  late YandexMapController yandexMapController;
  List<MapObject> listOfMarker = [];
  Point storeLocation =
      const Point(latitude: 40.2725769, longitude: 68.8169827);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationMapController>().init();
      drawMarker();
    });
    super.initState();
  }

  drawMarker() async {
    if (context.read<LocationMapController>().currentLocation != null) {
      listOfMarker.clear();
      listOfMarker.add(PlacemarkMapObject(
        mapId: const MapObjectId("start"),
        point: context.read<LocationMapController>().currentLocation ??
            storeLocation,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage("assets/map.webp"),
              scale: 0.3),
        ),
        opacity: 1,
      ));
      listOfMarker.add(PlacemarkMapObject(
        mapId: const MapObjectId("end"),
        point: storeLocation,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage("assets/map.webp"),
            scale: 0.3,
          ),
        ),
        opacity: 1,
      ));
      var res = await YandexDriving.requestRoutes(points: [
        RequestPoint(
            point: context.read<LocationMapController>().currentLocation ??
                storeLocation,
            requestPointType: RequestPointType.wayPoint),
        RequestPoint(
            point: storeLocation, requestPointType: RequestPointType.wayPoint),
      ], drivingOptions: const DrivingOptions())
          .result;
      res.routes?.asMap().forEach((index, element) {
        listOfMarker.add(
          PolylineMapObject(
              onTap: (s, i) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Column(
                          children: [
                            Text(element.metadata.weight.distance.text),
                            // Text(
                            //     "Distance : ${double.parse(element.metadata.weight.distance.text.substring(0, element.metadata.weight.distance.text.indexOf("mi") - 1)) * 1.6} km"),
                            Text(
                                "Distance : ${(element.metadata.weight.distance.text)} "),
                          ],
                        ),
                      );
                    });
              },
              mapId: MapObjectId("id$index"),
              polyline: Polyline(points: element.geometry),
              strokeWidth: 2,
              strokeColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              outlineColor: Colors.teal),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LocationMapController>();
    final event = context.read<LocationMapController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: YandexMap(
        logoAlignment: const MapAlignment(
            horizontal: HorizontalAlignment.left,
            vertical: VerticalAlignment.bottom),
        // mapType: MapType.satellite,
        mapObjects: [...listOfMarker],

        onMapCreated: (YandexMapController controller) {
          yandexMapController = controller;
          yandexMapController.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: storeLocation),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          event.init();
        },
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
