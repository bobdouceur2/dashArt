import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'nav_bar_music_model.dart';
export 'nav_bar_music_model.dart';

class NavBarMusicWidget extends StatefulWidget {
  const NavBarMusicWidget({super.key});

  @override
  State<NavBarMusicWidget> createState() => _NavBarMusicWidgetState();
}

class _NavBarMusicWidgetState extends State<NavBarMusicWidget> {
  late NavBarMusicModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarMusicModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
