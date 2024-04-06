import 'dart:convert';
import 'dart:io';
import 'dart:async';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'oeuvres_louvres_model.dart';
export 'oeuvres_louvres_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LouvresData {
  static void recordClick(String nom) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final Map<String, dynamic> clickData = {
      'nom': nom,
      'timestamp': timestamp,
    };
    final jsonData = json.encode(clickData);
    print(jsonData);
    final response = await http.post(
      Uri.parse('http://localhost:3000/save-click'),
      body: jsonData,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Click data recorded successfully');
    } else {
      print('Failed to record click data: ${response.statusCode}');
    }
  }
}

class OeuvresLouvresWidget extends StatefulWidget {
  const OeuvresLouvresWidget({Key? key}) : super(key: key);

  @override
  State<OeuvresLouvresWidget> createState() => _OeuvresLouvresWidgetState();
}

class _OeuvresLouvresWidgetState extends State<OeuvresLouvresWidget> {
  late OeuvresLouvresModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OeuvresLouvresModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme
            .of(context)
            .primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme
              .of(context)
              .primary,
          automaticallyImplyLeading: false,
          title: Text(
            "Galerie d'oeuvres",
            style: FlutterFlowTheme
                .of(context)
                .headlineMedium
                .override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22.0,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: FutureBuilder(
                  future: loadJsonImageLouvres(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child:
                        Text('Error loading data: ${snapshot.error}'),
                      );
                    } else {
                      final Map<String, dynamic>? imagesData = snapshot.data;
                      final List<String> imageUrls = imagesData?.values.cast<String>().toList() ?? [];
                      final List<String> imageName = imagesData?.keys.cast<String>().toList() ?? [];

                      //print(snapshot);
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: GridView.builder(
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: imageUrls?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                //_incrementCounter(artworks![index]);
                                _showImageDialog(context, imageUrls![index]);
                                //LouvresData.recordClick();
                                print(imageName[index]);
                                LouvresData.recordClick(imageName[index]);

                              },
                              child: Image.network(
                                imageUrls![index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0xFF212222),
          insetPadding: EdgeInsets.all(0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }







}