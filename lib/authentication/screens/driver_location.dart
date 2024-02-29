import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class DriverLocation {
  final double latitude;
  final double longitude;

  DriverLocation(this.latitude, this.longitude);

  Future<void> updateLocationInFirestore(String driverId) async {
    Location location = Location();
    PermissionStatus hasPermissions = await location.hasPermission();
    if (hasPermissions == PermissionStatus.denied) {
      await location.requestPermission();
    }
    location.onLocationChanged.listen((LocationData locationData) async {
      double latitude = locationData.latitude ?? 0.0;
      double longitude = locationData.longitude ?? 0.0;

      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(driverId)
          .set({
        'latitude': latitude,
        'longitude': longitude,
        'id': driverId,
          });
    });
  }
}
