import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:vshare/resources/Colors.dart';
import 'package:vshare/services/food_donate_modal.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  Location location = Location();
  LatLng? currentLocation;
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void _updateLocation(LatLng selectedLocation) {
    setState(() {
      latitude = selectedLocation.latitude;
      longitude = selectedLocation.longitude;
      currentLocation = selectedLocation;
    });
  }

  Future<void> getCurrentLocation() async {
    LocationData currentLocationData = await location.getLocation();
    setState(() {
      latitude = currentLocationData.latitude!;
      longitude = currentLocationData.longitude!;
      currentLocation = LatLng(latitude, longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodDonateModal = Provider.of<FoodDonateModal>(context, listen: true);

    return Scaffold(
      backgroundColor: lightGreenColor,
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              foodDonateModal.setLocation(currentLocation);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: lightGreenColor,
        centerTitle: true,
        title: const Text(
          'Pick Location',
          style: TextStyle(
            fontFamily: "PoppinsSemibold",
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : GoogleMap(
              onTap: _updateLocation,
              initialCameraPosition: CameraPosition(
                zoom: 15,
                target: currentLocation!,
              ),
              markers: <Marker>{
                Marker(
                  markerId: const MarkerId("Marker"),
                  position: currentLocation!,
                ),
              },
            ),
    );
  }
}
