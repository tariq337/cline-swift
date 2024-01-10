import 'dart:async';
import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:client_swift/Unit/StaticColors.dart';
import 'package:client_swift/Unit/Url.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Widgets/BottomSheetView.dart';
import 'package:client_swift/models/OrdersModel.dart';
import 'package:client_swift/server/DioSever.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_api/mapbox_api.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  Details ordersDetails;
  MapScreen({
    super.key,
    required this.ordersDetails,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with DioServer {
  Dio dio = Dio();
  GetStorage localDB = GetStorage();

  List<LatLng> polylineCoordinates = [];

  MapboxApi mapbox = MapboxApi(
    accessToken:
        'pk.eyJ1IjoidGFyaXEzMzciLCJhIjoiY2xuYXNqOGRsMDcycDJqbzM0eWluZ3ozMCJ9.NJDsZTYoyoPN5zLXOZlhLQ',
  );
  Future<void> addApiKey() async {
    dio.options.headers['apiKey'] = await localDB.read("apiKey");
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    createPolylines();
    getLocation();
  }

  LatLng location = LatLng(0, 0);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(
              double.parse(
                  widget.ordersDetails.points![0].point!.split(",")[0]),
              double.parse(
                  widget.ordersDetails.points![0].point!.split(",")[1])),
          zoom: 16.0,
          maxZoom: 19,
          minZoom: 15,
        ),
        nonRotatedChildren: [
          PolylineLayer(
            polylines: [
              Polyline(
                points: polylineCoordinates,
                color: Colors.yellow,
                strokeWidth: 4.0,
              ),
            ],
          ),
          MarkerLayer(markers: [
            Marker(
                height: 50,
                width: 50,
                point: location,
                builder: (ctx) => AvatarGlow(
                      duration: const Duration(milliseconds: 600),
                      glowColor: classColors.bgColor,
                      repeat: true,
                      startDelay: const Duration(milliseconds: 600),
                      child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: classColors.bgColor, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.drive_eta,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )),
            Marker(
                height: 50,
                width: 50,
                point: LatLng(
                    double.parse(
                        widget.ordersDetails.points![0].point!.split(",")[0]),
                    double.parse(
                        widget.ordersDetails.points![0].point!.split(",")[1])),
                builder: (ctx) => GestureDetector(
                      onTap: () async {
                        await BottomSheetView(
                            context: context,
                            name: widget.ordersDetails.points![0].name!,
                            isCline: true,
                            phoneNumber:
                                widget.ordersDetails.points![0].phoneNumber!,
                            state:
                                widget.ordersDetails.points![0].state!.id ?? 0,
                            onPhone: () async {
                              await _makePhoneCall(
                                  widget.ordersDetails.points![0].phoneNumber!);
                            });
                      },
                      child: AvatarGlow(
                        duration: const Duration(milliseconds: 600),
                        glowColor: classColors.bgColor,
                        repeat: true,
                        startDelay: const Duration(milliseconds: 600),
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: classColors.bgColor,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )),
            for (int index = 1;
                index < (widget.ordersDetails.points ?? []).length;
                index++)
              Marker(
                  height: 50,
                  width: 50,
                  point: LatLng(
                      double.parse(widget.ordersDetails.points![index].point!
                          .split(",")[0]),
                      double.parse(widget.ordersDetails.points![index].point!
                          .split(",")[1])),
                  builder: (ctx) => InkWell(
                        onTap: () async {
                          await BottomSheetView(
                              context: context,
                              name: widget.ordersDetails.points![index].name!,
                              isCline: false,
                              description: widget.ordersDetails.points![index]
                                      .description ??
                                  "",
                              phoneNumber: widget
                                  .ordersDetails.points![index].phoneNumber!,
                              state: widget
                                      .ordersDetails.points![index].state!.id ??
                                  0,
                              onPhone: () async {
                                await _makePhoneCall(widget
                                    .ordersDetails.points![index].phoneNumber!);
                              });
                        },
                        child: AvatarGlow(
                          duration: const Duration(milliseconds: 600),
                          glowColor: StaticColors((widget.ordersDetails
                                          .points![index].state!.id ??
                                      0) ==
                                  3
                              ? widget.ordersDetails.points![0].state!.id ?? 0
                              : widget.ordersDetails.points![index].state!.id ??
                                  0),
                          repeat: true,
                          startDelay: const Duration(milliseconds: 600),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: StaticColors((widget.ordersDetails
                                                .points![index].state!.id ??
                                            0) ==
                                        3
                                    ? widget.ordersDetails.points![0].state!
                                            .id ??
                                        0
                                    : widget.ordersDetails.points![index].state!
                                            .id ??
                                        0),
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.person_pin_outlined,
                              size: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      )),
          ]),
        ],
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: const {
              'accessToken':
                  'pk.eyJ1IjoidGFyaXEzMzciLCJhIjoiY2xuYXNqOGRsMDcycDJqbzM0eWluZ3ozMCJ9.NJDsZTYoyoPN5zLXOZlhLQ',
              'id': 'mapbox/outdoors-v12',
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: classColors.bgColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.clear,
            color: Colors.white,
          )),
    );
  }

  Future<void> getLocation() async {
    await addApiKey();

    _timer = Timer(const Duration(milliseconds: 1400), () async {
      await get(
          dio: dio,
          url: unitUrl.locationDelivery(widget.ordersDetails.id!),
          key: "key");
    });
  }

  @override
  void output(String key, data) {
    // TODO: implement output
    super.output(key, data);
    if (!(location ==
        LatLng(double.parse(data["location"].split(",")[0]),
            double.parse(data["location"].split(",")[1])))) {
      setState(() {
        errorMsg = "";
        location = LatLng(double.parse(data["location"].split(",")[0]),
            double.parse(data["location"].split(",")[1]));
      });
    }
  }

  String errorMsg = "";

  @override
  void error(String error) {
    // TODO: implement error
    super.error(error);
    if (error.isNotEmpty && errorMsg != error) {
      setState(() {
        errorMsg = error;
      });
    }
  }

  void createPolylines() async {
    polylineCoordinates.clear();
    final response = await mapbox.directions.request(
      profile: NavigationProfile.DRIVING_TRAFFIC,
      overview: NavigationOverview.FULL,
      geometries: NavigationGeometries.GEOJSON,
      steps: true,
      coordinates: <List<double>>[
        [
          double.parse(widget.ordersDetails.points![0].point!.split(",")[0]),
          double.parse(widget.ordersDetails.points![0].point!.split(",")[1])
        ],
        for (int index = 1;
            index < (widget.ordersDetails.points ?? []).length;
            index++)
          [
            double.parse(
                widget.ordersDetails.points![index].point!.split(",")[0]),
            double.parse(
                widget.ordersDetails.points![index].point!.split(",")[1])
          ]
      ],
    );

    if (response.error == null) {
      var routeCoordinates = response.routes![0].geometry['coordinates'];
      for (int i = 0; i < routeCoordinates.length; i++) {
        var coordinate = routeCoordinates[i];
        polylineCoordinates.add(LatLng(coordinate[1], coordinate[0]));
      }
    } else {}
    log(polylineCoordinates.toString());

    setState(() {});
  }
}
