import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../application/location_map_controller.dart';
import '../../utils/component/my_form_field.dart';

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
  Widget build(BuildContext context) {
    final state = context.watch<LocationMapController>();
    final event = context.read<LocationMapController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          YandexMap(
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
          SafeArea(
            child: Container(
              // ignore: prefer_const_constructors
              margin: EdgeInsets.only(top: 16, right: 24, left: 24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyFormFiled(
                    title: "Search",
                    onChange: (s) async {
                      event.search(s);
                    },
                  ),
                  (state.searchText?.isNotEmpty ?? false)
                      ? FutureBuilder(
                          future: YandexSearch.searchByText(
                              searchText: state.searchText ?? "",
                              geometry: Geometry.fromBoundingBox(
                                  const BoundingBox(
                                      northEast: Point(
                                          longitude: 55.9289172707,
                                          latitude: 37.1449940049),
                                      southWest: Point(
                                          longitude: 73.055417108,
                                          latitude: 45.5868043076))),
                              searchOptions: const SearchOptions(
                                searchType: SearchType.none,
                                resultPageSize: 5,
                                geometry: true,
                              )).result,
                          builder: (contextt, value) {
                            if (value.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.data?.items?.length ?? 0,
                                  itemBuilder: (context2, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        listOfMarker.clear();
                                        listOfMarker.add(PlacemarkMapObject(
                                          mapId: const MapObjectId("start"),
                                          point: value.data?.items?[index]
                                                  .geometry.first.point ??
                                              storeLocation,
                                          icon: PlacemarkIcon.single(
                                            PlacemarkIconStyle(
                                                image: BitmapDescriptor
                                                    .fromAssetImage(
                                                        "assets/map.webp"),
                                                scale: 0.3),
                                          ),
                                          opacity: 1,
                                        ));
                                        listOfMarker.add(PlacemarkMapObject(
                                          mapId: const MapObjectId("end"),
                                          point: storeLocation,
                                          icon: PlacemarkIcon.single(
                                            PlacemarkIconStyle(
                                              image: BitmapDescriptor
                                                  .fromAssetImage(
                                                      "assets/map.webp"),
                                              scale: 0.3,
                                            ),
                                          ),
                                          opacity: 1,
                                        ));
                                        var res =
                                            await YandexDriving.requestRoutes(
                                                    points: [
                                              RequestPoint(
                                                  point: value
                                                          .data
                                                          ?.items?[index]
                                                          .geometry
                                                          .first
                                                          .point ??
                                                      storeLocation,
                                                  requestPointType:
                                                      RequestPointType
                                                          .wayPoint),
                                              RequestPoint(
                                                  point: storeLocation,
                                                  requestPointType:
                                                      RequestPointType
                                                          .wayPoint),
                                            ],
                                                    drivingOptions:
                                                        const DrivingOptions())
                                                .result;
                                        res.routes
                                            ?.asMap()
                                            .forEach((index, element) {
                                          listOfMarker.add(
                                            PolylineMapObject(
                                                onTap: (s, i) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Column(
                                                            children: [
                                                              Text(
                                                                  element.metadata.weight.distance.text),
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
                                                polyline: Polyline(
                                                    points: element.geometry),
                                                strokeWidth: 2,
                                                strokeColor: Colors.primaries[
                                                    Random().nextInt(Colors
                                                        .primaries.length)],
                                                outlineColor: Colors.teal),
                                          );
                                        });
                                        // ignore: use_build_context_synchronously
                                        event.search("");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                            "${value.data?.items?[index].name}, ${value.data?.items?[index].businessMetadata?.address.formattedAddress ?? ""}"),
                                      ),
                                    );
                                  });
                            } else if (value.hasError) {
                              return Text(value.error.toString());
                            } else {
                              return const CircularProgressIndicator();
                            }
                          })
                      : const SizedBox.shrink()
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
