import '/dashboard/dashboard_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/list_events/list_events_widget.dart';
import '/oeuvres_art_deco/oeuvres_art_deco_widget.dart';
import '/oeuvres_branly/oeuvres_branly_widget.dart';
import '/oeuvres_guimet/oeuvres_guimet_widget.dart';
import '/oeuvres_louvres/oeuvres_louvres_widget.dart';
import '/oeuvres_orangerie/oeuvres_orangerie_widget.dart';
import '/peinture/peinture_widget.dart';
import '/sculptures/sculptures_widget.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
