import '/components/nav_bar_music_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/home_page/home_page_widget.dart';
import 'list_fav_widget.dart' show ListFavWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListFavModel extends FlutterFlowModel<ListFavWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for NavBarMusic component.
  late NavBarMusicModel navBarMusicModel;

  @override
  void initState(BuildContext context) {
    navBarMusicModel = createModel(context, () => NavBarMusicModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    navBarMusicModel.dispose();
  }
}
