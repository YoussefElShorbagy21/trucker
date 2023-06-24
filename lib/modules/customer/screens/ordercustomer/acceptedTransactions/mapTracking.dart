import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:location/location.dart';



class MapTracking extends StatefulWidget {
  double sourceLatLo;
  double sourceLatLa;
  double destinationLo;
  double destinationLa;
  MapTracking({Key? key,
    required this.sourceLatLa,required this.sourceLatLo,required this.destinationLa,required this.destinationLo,
  }) : super(key: key);

  @override
  State<MapTracking> createState() => _MapTrackingState();
}

class _MapTrackingState extends State<MapTracking> {
  // Mapbox Maps SDK related
  final List<CameraPosition> _kTripEndPoints = [];
  late MapboxMapController controller;
  late CameraPosition _initialCameraPosition;

  // Directions API response related
  late Map geometry;
  late LocationData  _locationData;

  @override
  void initState() {
    print('sourceLatLowidget:${widget.sourceLatLo}  sourceLatLa:${widget.sourceLatLa}'
        'destinationLo:${widget.destinationLo} destinationLa:${widget.destinationLa}');
    // initialise distance
    _initialiseDirectionsResponse();

    // initialise initialCameraPosition, address and trip end points
    _initialCameraPosition = CameraPosition(
        target: OrderCubit.get(context).getCenterCoordinatesForPolyline(geometry), zoom: 50);

    for (String type in ['source', 'destination']) {
      _kTripEndPoints.add(CameraPosition(target:OrderCubit.get(context).getTripLatLngFromSharedPrefs(type,
          widget.sourceLatLo,
          widget.sourceLatLa,
          widget.destinationLo,
          widget.destinationLa)
      )
      );
    }
    super.initState();
  }

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
      await controller.addSymbol(
        SymbolOptions(
          geometry: _kTripEndPoints[i].target,
          iconSize: 0.1,
          iconImage: "assets/images/png-transparent-marker-map-interesting-places-the-location-on-the-map-the-location-of-the-thumbnail.png",
        ),
      );
    }
    _addSourceAndLineLayer();
    _startTracking();
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
    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
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
    Location().onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _locationData = currentLocation;
        print('for update tracking');
        print(currentLocation);
      });
      _updateCamera();
    });
  }

  void _updateCamera() {
    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(_locationData.latitude!, _locationData.longitude!),
      ),
    );
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: MapboxMap(
            trackCameraPosition: true,
            myLocationEnabled: true,
            accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoadedCallback,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
          ),
        ),
      ),
    );
  }
}
