import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login/modules/customer/screens/home/cubit/state.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/constants.dart';
import '../screens/home/cubit/cubit.dart';

class Mapid extends StatefulWidget {
  final int i ;
  Mapid( {Key? key, required this.i}) : super(key: key);
  @override
  State<Mapid> createState() => _MapidState();
}
class _MapidState extends State<Mapid> {
  MapboxMapController? mapController;
  LatLng? markerLatLng;
  Future<Uint8List> loadMarkerImage() async {
    var byteData = await rootBundle.load("assets/images/png-transparent-marker-map-interesting-places-the-location-on-the-map-the-location-of-the-thumbnail.png");
    return byteData.buffer.asUint8List();
  }
  @override
  Widget build(BuildContext context) {
    print('in map');
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(latLng);
        return Scaffold(
            body: MapboxMap(
              trackCameraPosition: true,
              accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
              initialCameraPosition: CameraPosition(target: latLng, zoom: 14,),
              onMapCreated: (controller) async{
                mapController = controller;
              },
              onMapClick: (point, latLngUp) async {
                setState(() {
                  markerLatLng = latLngUp;
                });
                if (mapController != null) {
                  var markerImage = await loadMarkerImage();
                  mapController!.addImage('marker', markerImage);
                  mapController!.clearSymbols();
                  mapController!.addSymbol(SymbolOptions(
                    geometry: latLngUp,
                    iconSize: 0.1,
                    iconImage: "marker",
                    iconOffset: const Offset(0, -150),
                  ));
                  print('markerLatLng!.latitude: ${markerLatLng!.latitude}');
                  print('markerLatLng!.longitude: ${markerLatLng!.longitude}');
                  HomeScreenCubit.get(context).getAddressFromLatLng(markerLatLng!.latitude,markerLatLng!.longitude,widget.i);

                }
              },
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
              print(HomeScreenCubit.get(context).startLocationControllerMap.text);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

}