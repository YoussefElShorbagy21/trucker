import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../../shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MapTracking extends StatefulWidget {
  String id ;
  String serviceId ;
  double sourceLatLo;
  double sourceLatLa;
  double destinationLo;
  double destinationLa;
  MapTracking({Key? key,
    required this.sourceLatLa,required this.sourceLatLo,required this.destinationLa,required this.destinationLo,
    required this.id , required this.serviceId
  }) : super(key: key);

  @override
  State<MapTracking> createState() => _MapTrackingState();
}

class _MapTrackingState extends State<MapTracking> {
  // Mapbox Maps SDK related
  final List<CameraPosition> _kTripEndPoints = [];
  MapboxMapController? controller ;
  late CameraPosition _initialCameraPosition;
  Future<Uint8List> loadMarkerImage() async {
    var byteData = await rootBundle.load("assets/images/6643396.png");
    return byteData.buffer.asUint8List();
  }
  // Directions API response related
  late Map geometry;
  late LocationData _locationData;
  final referenceDataset = FirebaseDatabase.instance ;
  @override
  void initState() {
    print(
        'sourceLatLowidget:${widget.sourceLatLo}  sourceLatLa:${widget.sourceLatLa}'
        'destinationLo:${widget.destinationLo} destinationLa:${widget.destinationLa}');
    // initialise distance
    _initialiseDirectionsResponse();

    // initialise initialCameraPosition, address and trip end points
    _initialCameraPosition = CameraPosition(
        target:
            OrderCubit.get(context).getCenterCoordinatesForPolyline(geometry),
        zoom: 50);

    for (String type in ['source', 'destination']) {
      _kTripEndPoints.add(CameraPosition(
          target: OrderCubit.get(context).getTripLatLngFromSharedPrefs(
              type,
              widget.sourceLatLo,
              widget.sourceLatLa,
              widget.destinationLo,
              widget.destinationLa)));
    }

    super.initState();
  }
  dynamic latitude ;
  dynamic longitude ;
  _initialiseDirectionsResponse() {
    print('in _initialiseDirectionsResponse');
    geometry = OrderCubit.get(context).modifiedResponse['geometry'];
    print(geometry);
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {
    for (int i = 0; i < _kTripEndPoints.length; i++) {
      await controller!.addSymbol(
        SymbolOptions(
          geometry: _kTripEndPoints[i].target,
          iconSize: 0.1,
          iconImage:
              "assets/images/png-transparent-marker-map-interesting-places-the-location-on-the-map-the-location-of-the-thumbnail.png",
        ),
      );
    }
    _addSourceAndLineLayer();
    HomeCubit.get(context).oneUserData.userData.role ==
        "service_provider" ? _startTracking() : print('ahmed') ;
  }

  _addSourceAndLineLayer() async {
    // Create a polyLine between source and destination
    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    // Add new source and lineLayer
    await controller!.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller!.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.indigo.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 3,
      ),
    );
    print(_fills);
  }

  void _startTracking() {
    final ref = referenceDataset.ref();
    Location().onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _locationData = currentLocation;
        print('for update tracking');
        print(currentLocation.latitude);
        ref.child(widget.id.toString()).child(uid.toString()).child('currentLocation')
        .child('latitude').set(currentLocation.latitude)
        .asStream();

        ref.child(widget.id.toString()).child(uid.toString()).child('currentLocation')
            .child('longitude').set(currentLocation.longitude)
            .asStream();
      });
      _updateCamera();
    });
  }

  void _updateCamera() {
    controller!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(_locationData.latitude!, _locationData.longitude!),
      ),
    );
  }

  Future<void> liveLocation() async{
    print('liveLocation');
      final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      final DatabaseReference latitudeRef = databaseRef.child(widget.id)
          .child(widget.serviceId)
          .child('currentLocation')
          .child('latitude');

      final DatabaseReference longitudeRef = databaseRef.child(widget.id)
          .child(widget.serviceId)
          .child('currentLocation')
          .child('longitude');

      latitudeRef.onValue.listen((event) {
        setState(() {
          latitude = event.snapshot.value;
          print('latitude in snapshot.value $latitude');
        });
      });

      longitudeRef.onValue.listen((event) {
        setState(() {
          longitude = event.snapshot.value;
          print('longitude in snapshot.value $longitude');
        });
      });

    var markerImage = await loadMarkerImage();
    await controller!.addImage('marker', markerImage);

    if (latitude != null && longitude != null)
      {
        await controller!.addSymbol(SymbolOptions(
          geometry: LatLng(latitude!,longitude!),
          iconSize: 0.1,
          iconImage: "marker",
          iconOffset: const Offset(0, -150),
        ));
        controller!.clearSymbols();
        controller!.addSymbol(SymbolOptions(
          geometry: LatLng(latitude!,longitude!),
          iconSize: 0.1,
          iconImage: "marker",
          iconOffset: const Offset(0, -150),
        ));
      }

    print('latitude in onMapCreate $latitude');
    print('longitude in onMapCreate $longitude');
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Review Ride'),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            print('Builder');
            HomeCubit.get(context).oneUserData.userData.role !=
                "service_provider" ? liveLocation() : print('Builder');
            return BlocConsumer<OrderCubit, OrderStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: MapboxMap(
                trackCameraPosition: true,
                myLocationEnabled:    HomeCubit.get(context).oneUserData.userData.role ==
                    "service_provider"? true : false,
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                onUserLocationUpdated: (value){
                  print(value);
                },
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
              ),
            );
  },
);
          }
        ),
      ),
    );
  }
}
