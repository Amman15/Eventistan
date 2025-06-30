import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapScreen extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const MapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Event Location',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: GoogleMapWidget(
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }
}

class GoogleMapWidget extends ConsumerStatefulWidget {
  final double latitude;
  final double longitude;

  const GoogleMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  ConsumerState<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends ConsumerState<GoogleMapWidget> {
  GoogleMapController? mapController;
  LatLng _currentPosition = const LatLng(0.0, 0.0);
  MapType _currentMapType = MapType.normal;
  bool _isMapInitialized = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    log("initState: Initialized GoogleMapWidget");
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
        msg: 'Location services are disabled. Please enable the services.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
          msg: 'Location permissions are denied.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
        msg:
            'Location permissions are permanently denied, we cannot request permissions.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
    return true;
  }

  Future<LatLng?> getLatLngFromGeolocation() async {
    try {
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) {
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      return LatLng(position.latitude, position.longitude);
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    return null;
  }

  void _onMapCreated(GoogleMapController controller) {
    log("Map created");
    mapController = controller;
    _isMapInitialized = true;
    _setMapBounds();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await getLatLngFromGeolocation();
      if (locData != null) {
        setState(() {
          _currentPosition = locData;
        });
        if (_isMapInitialized) {
          _setMapBounds();
        }
      }
    } catch (e, s) {
      log(
        "Error fetching user location.",
        error: e,
        stackTrace: s,
      );
    }
  }

  void _setMapBounds() {
    if (mapController == null ||
        (_currentPosition.latitude == 0.0 &&
            _currentPosition.longitude == 0.0)) {
      log("MapController is not initialized or currentPosition is (0.0, 0.0)");
      return;
    }

    LatLngBounds bounds;
    if (_currentPosition.latitude < widget.latitude) {
      bounds = LatLngBounds(
        southwest: _currentPosition,
        northeast: LatLng(widget.latitude, widget.longitude),
      );
    } else {
      bounds = LatLngBounds(
        southwest: LatLng(widget.latitude, widget.longitude),
        northeast: _currentPosition,
      );
    }

    mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
          bounds, 50), // 50 is the padding from the edges
    );
  }

  void _toggleMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("build: Building GoogleMap widget");
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 10.0,
          ),
          trafficEnabled: true,
          mapType: _currentMapType,
          markers: {
            Marker(
              markerId: const MarkerId('event_location'),
              position: LatLng(
                widget.latitude,
                widget.longitude,
              ),
              infoWindow: const InfoWindow(
                title: 'Event Location',
                snippet: 'This is where the event is held.',
              ),
            ),
            Marker(
              markerId: const MarkerId('current_location'),
              position: _currentPosition,
              infoWindow: const InfoWindow(
                title: 'Current Location',
              ),
            ),
          },
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: _toggleMapType,
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.map,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
