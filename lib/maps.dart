import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatelessWidget {
  const MapsWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var area = Set<Circle>();

    area.add(Circle(circleId: CircleId("Circle01"), 
    center: LatLng(-6.1881694,106.7126039), 
    radius: 128,
    strokeColor: Color.fromARGB(255, 1, 13, 22),
    strokeWidth: 1,
    fillColor: Color.fromARGB(255, 173, 191, 223)));

    var titiks = Set<Marker>();

    titiks.add(Marker(
      markerId: MarkerId('Marker 1'),
      position: LatLng(-6.2516515,106.7503694),
      infoWindow:InfoWindow(title: "Lippo Mall Puri")));

    titiks.add(Marker(
      markerId: MarkerId('Marker 2'),
      position: LatLng(-6.1881694,106.7126039),
      infoWindow:InfoWindow(title: "Universitas Mercu Buana")));

    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        circles: area,
        markers: titiks,
        mapToolbarEnabled: true,
        trafficEnabled: true,
        buildingsEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        indoorViewEnabled: true,
        compassEnabled: true,
        initialCameraPosition: 
        CameraPosition(
          zoom : 17 ,
          target: LatLng(-6.2062592,106.7843584)),),
    );
  }
}