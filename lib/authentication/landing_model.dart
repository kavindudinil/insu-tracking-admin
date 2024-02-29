import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'landing.dart' show LandingPage;
import 'package:flutter/material.dart';

class LandingPageModel extends FlutterFlowModel<LandingPage> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for emailAddress widget.

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {

  }

  @override
  void dispose() {
    unfocusNode.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
