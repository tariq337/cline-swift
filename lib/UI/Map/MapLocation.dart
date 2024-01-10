import 'package:avatar_glow/avatar_glow.dart';
import 'package:client_swift/Controll/UserControll.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/Messge.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapLocation extends StatefulWidget {
  const MapLocation({super.key});

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  MapController mapController = MapController();
  UserControll userControll = Get.put(UserControll());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(() {
        return Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(25.1572527, 55.4137894),
                zoom: 16.0,
                maxZoom: 18,
                minZoom: 11,
                onTap: (tapPosition, point) {
                  userControll.latLng(point);
                },
              ),
              nonRotatedChildren: [
                MarkerLayer(markers: [
                  Marker(
                      point: userControll.latLng.value,
                      rotateAlignment: AlignmentDirectional.topCenter,
                      rotateOrigin: const Offset(1, 1),
                      rotate: true,
                      builder: (ctx) => AvatarGlow(
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
                          ))),
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
            Positioned(
              bottom: Responsive.isMobile(context) ? 90 : 16,
              left: Responsive.isMobile(context) ? 20 : 16,
              child: FloatingActionButton(
                onPressed: () async {
                  await userControll.getLocationdata();
                  if (userControll.errorMsg.value.isNotEmpty) {
                    Messge.error(userControll.errorMsg.value, context);
                  } else {
                    mapController.move(
                        LatLng(userControll.locationData.latitude ?? 0,
                            userControll.locationData.longitude ?? 0),
                        16);
                    Messge.notification(
                        language[modeControll.LanguageValue]["done"], context);
                  }
                },
                child: const Icon(Icons.location_searching_rounded),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: classColors.bgColor,
                  padding: const EdgeInsets.all(
                    13,
                  ),
                ),
                onPressed: () {
                  userControll.setLoaction();
                  pageUsrtController.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                label: TextUnit.Textsub(
                    text: language[modeControll.LanguageValue]["done"],
                    color: Colors.white,
                    size: 11),
              ),
            ),
          ],
        );
      }),
    );
  }
}
