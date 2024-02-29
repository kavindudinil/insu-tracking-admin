import 'dart:async';

import 'package:geolocator/geolocator.dart';

Position? driverCurrentPosition;
StreamSubscription<Position>? positionStreamHomePage;
StreamSubscription<Position>? positionStreamNewTripPage;
