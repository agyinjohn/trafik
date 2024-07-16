import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:traffic/screens/alternative_route_page.dart';
import 'package:traffic/screens/estimated_time_page.dart';
import 'package:traffic/utils/models/usermodel.dart';
import 'package:traffic/utils/providers/userprovider.dart';
import 'package:traffic/widgets/drawer.dart';

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
    print(user);
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
      drawer: user != null
          ? SideDrawer(url: user!.profileUrl, name: user!.name)
          : null,
      body: user == null || currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
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
                DraggableScrollableSheet(
                  initialChildSize: 0.3,
                  minChildSize: 0.3,
                  maxChildSize: 0.6,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                        height: 400,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.lightGreen
                                              .withOpacity(0.1)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const EstimatedTimePage())),
                                              child: const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.bookmark,
                                                    color: Colors.lightGreen,
                                                  ),
                                                  Text("Estimated \ntime")
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AlternativeRoutePage())),
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.lightGreen
                                                .withOpacity(0.1)),
                                        child: const Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.network_wifi_sharp,
                                                    color: Colors.lightGreen,
                                                  ),
                                                  Text("Alternative \nroutes")
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.lightGreen
                                              .withOpacity(0.1)),
                                      child: const Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.mouse,
                                                  color: Colors.lightGreen,
                                                ),
                                                Text("Suitable \ntramsport")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.lightGreen,
                                      child: Center(
                                        child: Icon(
                                          Icons.directions,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "From",
                                      prefixIcon: Icon(
                                        Icons.radio_button_checked,
                                        color: Colors.grey,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.location_on,
                                        color: Colors.lightGreen,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightGreen),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightGreen),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "To",
                                      prefixIcon: Icon(
                                        Icons.radio_button_off,
                                        color: Colors.lightGreen,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.location_on,
                                        color: Colors.lightGreen,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightGreen),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightGreen),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ],
            ),
    );
  }
}
