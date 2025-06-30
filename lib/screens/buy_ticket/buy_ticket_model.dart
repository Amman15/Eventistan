import '/flutter_flow/flutter_flow_util.dart';
import 'buy_ticket_widget.dart' show BuyTicketWidget;
import 'package:flutter/material.dart';

class BuyTicketModel extends FlutterFlowModel<BuyTicketWidget> {
  ///  Local state fields for this page.

  int total = 1;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for CountController widget.
  int countControllerValue = 1;

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
