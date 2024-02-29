import 'dart:async';

import 'package:flutter/services.dart';

import 'driver_location.dart';

class DriverBackgroundService {
  static final _service = DriverBackgroundService._internal();

  factory DriverBackgroundService() {
    return _service;
  }

  DriverBackgroundService._internal();

  Future<void> startService(String driverId) async {
    Timer.periodic(const Duration(minutes: 1), (_) async {
      try {
        await DriverLocation(0.0, 0.0).updateLocationInFirestore(driverId);
      } on PlatformException catch (e) {
        // Handle platform errors (e.g., access denied)
      }
    });
  }
}

