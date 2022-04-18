import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double lat = 31.50161;

  double lon = 34.46672;
  Set<Marker> myMarkers =  <Marker>{};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMarkers
        .add(Marker(markerId: MarkerId('gaza'),position: LatLng(lat, lon)));
  setState(() {
    
  });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Location Screen')),
      body:  GoogleMap(
        markers: myMarkers,
          initialCameraPosition:
              CameraPosition(zoom: 10, target: LatLng(31.50161, 34.46672))),
    );
  }
}
