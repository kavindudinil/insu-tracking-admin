
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'logout.dart' show LogoutWidget;
import 'package:flutter/material.dart';

class LogoutModel extends FlutterFlowModel<LogoutWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
