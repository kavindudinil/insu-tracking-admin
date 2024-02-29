import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insu_tracking_admin/authentication/screens/driver_background_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dash_bubble/dash_bubble.dart';
import 'package:animations/animations.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
// import 'package:location/location.dart';

import 'package:external_app_launcher/external_app_launcher.dart';
import '../../helpers/constants.dart';
import '../../provider/user_provider.dart';
import '../../pushNotifications/push_notification_system.dart';
import 'home_model.dart';
import 'logout.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late List06UserSearchModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var collection = FirebaseFirestore.instance.collection('requestUsers');
  late List<Map<String, dynamic>> items;
  bool isLoading = true;
  Position? currentPositionOfDriver;
  Color colorToShow = Colors.green;
  String titleToShow = "GO ONLINE NOW";
  bool isDriverAvailable = false;
  DatabaseReference? newTripRequestReference;
  // MapThemeMethods themeMethods = MapThemeMethods();

  getCurrentLiveLocationOfDriver() async
  {
    Position positionOfUser = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositionOfDriver = positionOfUser;
    driverCurrentPosition = currentPositionOfDriver;

  }


  goOnlineNow() {
    //all drivers who are Available for new trip requests
    Geofire.initialize("onlineDrivers");

    Geofire.setLocation(
      FirebaseAuth.instance.currentUser!.uid,
      currentPositionOfDriver!.latitude,
      currentPositionOfDriver!.longitude,
    );

    newTripRequestReference = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("newTripStatus");
    newTripRequestReference!.set("waiting");

    newTripRequestReference!.onValue.listen((event) {});
  }

  setAndGetLocationUpdates() {
    positionStreamHomePage =
        Geolocator.getPositionStream().listen((Position position) {
      currentPositionOfDriver = position;

      if (isDriverAvailable == true) {
        Geofire.setLocation(
          FirebaseAuth.instance.currentUser!.uid,
          currentPositionOfDriver!.latitude,
          currentPositionOfDriver!.longitude,
        );
      }

      LatLng positionLatLng = LatLng(position.latitude, position.longitude);
    });
  }

  goOfflineNow() {
    //stop sharing driver live location updates
    Geofire.removeLocation(FirebaseAuth.instance.currentUser!.uid);

    //stop listening to the newTripStatus
    newTripRequestReference!.onDisconnect();
    newTripRequestReference!.remove();
    newTripRequestReference = null;
  }

  initializePushNotificationSystem()
  {
    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken();
    notificationSystem.startListeningForNewNotification(context);
  }

  Future<bool> overlay(
      {BubbleOptions? bubbleOptions, VoidCallback? onTap}) async {
    final isGranted = await DashBubble.instance.requestOverlayPermission();
    if (isGranted) {
      await DashBubble.instance.startBubble(
        bubbleOptions: bubbleOptions,
        onTap: onTap,
      );
    }
    return isGranted;
  }

  Future<void> stopOverlay() async {
    await DashBubble.instance.stopBubble();
  }

  _listCount() async {
    late List<Map<String, dynamic>> tempList = [];
    var data = await collection.get();
    for (var element in data.docs) {
      tempList.add(element.data());
    }

    setState(() {
      items = tempList;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _listCount();
    _model = createModel(context, () => List06UserSearchModel());

    getCurrentLiveLocationOfDriver();
    initializePushNotificationSystem();
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Admin Panel',
            style: FlutterFlowTheme.of(context).headlineMedium,
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              // want to add image instead of icon
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    // Adjust radius as needed
                    border: Border.all(
                      color: Colors.grey, // Customize border color
                      width: 2.0, // Adjust border width
                    ),
                  ),
                  child: InkWell(
                    radius: 30,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogoutWidget(),
                        ),
                      );
                    },
                    child: ClipOval(
                      child: Provider.of<UserProvider>(context, listen: true)
                                      .photoUrl ==
                                  null ||
                              Provider.of<UserProvider>(context, listen: true)
                                      .photoUrl ==
                                  ''
                          ? const Icon(
                              Icons.account_circle,
                              // Replace with your desired profile icon
                              color: Colors.grey, // Adjust color as needed
                              size: 40,
                            )
                          : Image.network(
                              Provider.of<UserProvider>(context, listen: true)
                                      .photoUrl ??
                                  "",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                    child:
                                        CircularProgressIndicator()); // Add a loading indicator
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.account_circle,
                                  // Or a different placeholder icon
                                  color: Colors.grey,
                                  size: 40,
                                );
                              },
                            ),
                    ),
                  )),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        onChanged: (_) => EasyDebounce.debounce(
                          '_model.textController',
                          const Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Search members...',
                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        validator:
                            _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 44,
                        icon: Icon(
                          Icons.search_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                child: Text(
                  'Members in Project',
                  style: FlutterFlowTheme.of(context).labelMedium,
                ),
              ),
              Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
                  child: Container(
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x34090F13),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      alignment: const AlignmentDirectional(-0.75, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 25),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 8, 0, 0),
                                child: Text(
                                  'UserName',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 4, 0, 0),
                                child: Text(
                                  'Remove',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          FFButtonWidget(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isDismissible: false,
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black87,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5.0,
                                          spreadRadius: 0.5,
                                          offset: Offset(
                                            0.7,
                                            0.7,
                                          ),
                                        ),
                                      ],
                                    ),
                                    height: 221,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 18),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 11),

                                          Text(
                                            (!isDriverAvailable)
                                                ? "GO ONLINE NOW"
                                                : "GO OFFLINE NOW",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 21),

                                          Text(
                                            (!isDriverAvailable)
                                                ? "You are about to go online, you will become available to receive trip requests from users."
                                                : "You are about to go offline, you will stop receiving new trip requests from users.",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white30,
                                            ),
                                          ),

                                          const SizedBox(height: 25),

                                          // Removed the problematic SizedBox
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "BACK",
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    if (!isDriverAvailable) {
                                                      // go online
                                                      goOnlineNow();

                                                      // get driver location updates
                                                      setAndGetLocationUpdates();

                                                      Navigator.pop(context);

                                                      setState(() {
                                                        colorToShow =
                                                            Colors.pink;
                                                        titleToShow =
                                                            "GO OFFLINE NOW";
                                                        isDriverAvailable =
                                                            true;
                                                      });
                                                    } else {
                                                      // go offline
                                                      goOfflineNow();

                                                      Navigator.pop(context);

                                                      setState(() {
                                                        colorToShow =
                                                            Colors.green;
                                                        titleToShow =
                                                            "GO ONLINE NOW";
                                                        isDriverAvailable =
                                                            false;
                                                      });
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        (titleToShow ==
                                                                "GO ONLINE NOW")
                                                            ? Colors.green
                                                            : Colors.pink,
                                                  ),
                                                  child: const Text(
                                                    "CONFIRM",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            text: (!isDriverAvailable)
                                ? "GO ONLINE NOW"
                                : "GO OFFLINE NOW",
                            options: FFButtonOptions(
                              width: 150,
                              height: 44,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              hoverColor: FlutterFlowTheme.of(context).primary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                child: Text(
                  'Add Members',
                  style: FlutterFlowTheme.of(context).labelMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 44),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 4, 16, 8),
                            child: GestureDetector(
                              onTap: () =>
                                  print("object"), // Modified for popup
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x32000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: items[index]['photoUrl'] ==
                                                    null ||
                                                items[index]['photoUrl'] == ''
                                            ? const Icon(
                                                Icons.account_circle,
                                                // Replace with your desired profile icon
                                                size: 36,
                                                color: Colors
                                                    .black12, // Adjust color as needed
                                              )
                                            : Image.network(
                                                items[index]['photoUrl'],
                                                width: 36,
                                                height: 36,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(12, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                items[index]['name'],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 4, 0, 0),
                                                    child: Expanded(
                                                      child: LayoutBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            BoxConstraints
                                                                constraints) {
                                                          String email =
                                                              items[index]
                                                                  ['email'];
                                                          double maxWidth =
                                                              constraints
                                                                  .maxWidth;

                                                          // Function to truncate email if it's too long
                                                          String truncateEmail(
                                                              String email,
                                                              double maxWidth) {
                                                            if (email.length >
                                                                20) {
                                                              // Set your desired length
                                                              email =
                                                                  '${email.substring(0, 20)}...';
                                                            }

                                                            return email;
                                                          }

                                                          bool isLandscape =
                                                              MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .landscape;

                                                          return Text(
                                                            isLandscape
                                                                ? items[index]
                                                                    ['email']
                                                                : truncateEmail(
                                                                    email,
                                                                    maxWidth),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium,
                                                            // textDirection: TextDirection.ltr,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // add the Check button
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 8, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            final result =
                                                await showModalBottomSheet<
                                                    bool>(
                                              context: context,
                                              builder: (context) =>
                                                  getBottomSheetContent(
                                                      context,
                                                      items[index]['latitude'],
                                                      items[index]['longitude'],
                                                      items[index]['name'],
                                                      items[index]['email'],
                                                      items[index]['photoUrl']),
                                            );
                                            if (result == true) {
                                              // Handle accepting the customer (e.g., show success message, update UI)
                                            } else {
                                              // Handle cancelling the request (e.g., show cancel message)
                                            }
                                          },
                                          text: 'View',
                                          options: FFButtonOptions(
                                            width: 70,
                                            height: 36,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                            elevation: 2,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBottomSheetContent(BuildContext context, double lat, double long,
      String user, String email, String avatarUrl) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Accept Customer?",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          // Customer details section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: avatarUrl == ''
                    ? const Icon(
                        Icons.account_circle,
                        // Replace with your desired profile icon
                        size: 60,
                        color: Colors.black12, // Adjust color as needed
                      )
                    : Image.network(
                        avatarUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user, // Replace with customer's name
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      double maxWidth = constraints.maxWidth;

                      // Function to truncate email if it's too long
                      String truncateEmail(String email, double maxWidth) {
                        if (email.length > 20) {
                          // Set your desired length
                          email = '${email.substring(0, 20)}...';
                        }

                        return email;
                      }

                      bool isLandscape = MediaQuery.of(context).orientation ==
                          Orientation.landscape;

                      return Text(
                        isLandscape ? email : truncateEmail(email, maxWidth),
                        style: FlutterFlowTheme.of(context).labelMedium,
                        // textDirection: TextDirection.ltr,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SwipeButton.expand(
            duration: const Duration(milliseconds: 200),
            thumb: const Icon(
              Icons.double_arrow_rounded,
              color: Colors.white,
            ),
            activeThumbColor: Colors.red,
            activeTrackColor: Colors.grey.shade300,
            onSwipe: () {
              Navigator.pop(context, true);
              _openMap(lat, long);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Swipped"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              "Swipe to Accept",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            bool isLandscape =
                MediaQuery.of(context).orientation == Orientation.landscape;
            return SizedBox(
              height: isLandscape ? 0 : 15,
            );
          }),
        ],
      ),
    );
  }

  Future<void> _openMap(double lat, double long) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    Uri urlN = Uri.parse(googleUrl);
    Future<bool> isGranted = overlay(
      bubbleOptions: BubbleOptions(
        bubbleIcon: 'infimage',
        bubbleSize: 50,
        enableClose: true,
        enableAnimateToEdge: true,
        enableBottomShadow: true,
        keepAliveWhenAppExit: false,
        closeBehavior: CloseBehavior.following,
      ),
      onTap: () async {
        launchApp();
        await stopOverlay();
      },
    );
    await DriverBackgroundService()
        .startService(Provider.of<UserProvider>(context, listen: false).id);
    if (await isGranted) {
      if (await launchUrl(urlN)) {
      } else {
        throw 'Could not launch $urlN';
      }
    } else {
      throw 'Could not launch $urlN';
    }
  }

  Future<void> launchApp() async {
    await LaunchApp.openApp(
      androidPackageName: 'com.example.insu_tracking_admin',
      openStore: false,
      // openStore: false
    );
  }
}
