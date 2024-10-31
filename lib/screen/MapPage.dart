import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  LocationData? _currentLocation;
  final Location _location = Location();

  // إحداثيات افتراضية (مثال: برج خليفة، دبي)
  static const LatLng _initialPosition = LatLng(25.1972, 55.2744);

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // تحقق من تفعيل خدمات الموقع
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        print('خدمات الموقع غير مفعلة.');
        return;
      }
    }

    // تحقق من إذن الوصول إلى الموقع
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print('إذن الوصول إلى الموقع مرفوض.');
        return;
      }
    }

    // احصل على موقع المستخدم الحالي
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      final locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });

      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(locationData.latitude!, locationData.longitude!),
          16, // تكبير الكاميرا بشكل مناسب
        ),
      );
    } catch (e) {
      print('حدث خطأ أثناء الحصول على الموقع: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الخريطة'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14,
        ),
        myLocationEnabled: true, // عرض موقع المستخدم
        myLocationButtonEnabled: true, // تفعيل زر الموقع الحالي
      ),
    );
  }
}
