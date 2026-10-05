import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng cairoLocation = LatLng(30.0444, 31.2357);

  static final Set<Marker> cairoMarker = {
    const Marker(
      markerId: MarkerId('cairo'),
      position: cairoLocation,
      infoWindow: InfoWindow(
        title: 'Cairo Governorate',
        snippet: 'Cairo, Egypt',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: cairoLocation, zoom: 11),
        markers: cairoMarker,
      ),
    );
  }
}
