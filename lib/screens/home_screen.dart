import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:traffic/utils/models/usermodel.dart';
import 'package:traffic/utils/providers/userprovider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _ConsumerHomeScreenState();
}

class _ConsumerHomeScreenState extends ConsumerState<HomeScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    loadUser();
    _getCurrentLocation();
  }

  Future<void> loadUser() async {
    final loadedUser = await ref.read(userProvider.notifier).loadUser();
    setState(() {
      user = loadedUser;
    });
  }

  late GoogleMapController mapController;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};
  List<Marker> markers = [];
  LocationData? currentLocation;
  final Location location = Location();

  final LatLng defaultCenter = const LatLng(37.7749, -122.4194);

  void _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await location.getLocation();
    setState(() {});
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    FirebaseFirestore.instance
        .collection('trafficUpdates')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        markers = snapshot.docs.map((doc) {
          final data = doc.data();
          final points = (data['route'] as List)
              .map((point) => LatLng(point['lat'], point['lng']))
              .toList();
          final status = data['status'];

          return Marker(
            markerId: MarkerId(doc.id),
            position: points.first,
            infoWindow: InfoWindow(title: 'Traffic Status', snippet: status),
          );
        }).toList();
      });
    });
  }

  void onTap(LatLng position) {
    setState(() {
      polylineCoordinates.add(position);
      polylines = {
        Polyline(
          polylineId: const PolylineId('route'),
          visible: true,
          points: polylineCoordinates,
          color: Colors.blue,
          width: 5,
        ),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.travel_explore_sharp))
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
      ),
      drawer: const Drawer(),
      body: Stack(
        children: [
          currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 11.0,
                  ),
                  polylines: polylines,
                  markers: markers.toSet(),
                  onTap: onTap,
                ),
        ],
      ),
    );
  }
}
