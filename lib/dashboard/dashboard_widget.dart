import 'package:dash_art/oeuvres_louvres/oeuvres_louvres_widget.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'dashboard_model.dart';
export 'dashboard_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>
    with TickerProviderStateMixin {

  bool _isLoading = true;
  late DashboardModel _model;
  List<Map<String, dynamic>> historiqueDataLouvres = [];
  List<Map<String, dynamic>> historiqueDataGuimet = [];
  List<Map<String, dynamic>> historiqueDataTotal = [];
  List<Map<String, dynamic>> VueDataLouvres = [];
  List<Map<String, dynamic>> VueDataGuimet = [];
  List<Map<String, dynamic>> VueDataTotal = [];
  List<Map<String, dynamic>> selectedDataPie1 = [];
  List<Map<String, dynamic>> selectedDataPie2 = [];
  List<Map<String, dynamic>> selectedDataPie = [];
  List<Map<String, dynamic>> selectedData1 = [];
  List<Map<String, dynamic>> selectedData2 = [];
  int sumOfViews = 0;


  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'columnOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 0.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 0.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 0.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardModel());
    fetchHistoriqueDataLouvres();
    fetchHistoriqueDataGuimet();
    fetchHistoriqueDataTotal();
    fetchVueDataGuimet();
    fetchVueDataLouvres();
    fetchVueDataTotal();
    fetchDataAndCalculatePieChartDataLouvres();
    fetchDataAndCalculatePieChartDataGuimet();
    _model.dropDownValueController = FormFieldController<String>('Total');
  }
  void fetchHistoriqueDataLouvres() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/last-requests-louvres'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> historiqueDataList = List<Map<String, dynamic>>.from(jsonData);
        setState(() {
          historiqueDataLouvres = historiqueDataList;
          _isLoading = false; // Hide loading indicator
        });
      } else {
        print('Failed to load historiqueData');
      }
    } catch (e) {
      print('Error fetching historiqueData: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator on error
      });
    }
  }
  void fetchHistoriqueDataGuimet() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/last-requests-guimet'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> historiqueDataList = List<Map<String, dynamic>>.from(jsonData);
        setState(() {
          historiqueDataGuimet = historiqueDataList;
          _isLoading = false; // Hide loading indicator
        });
      } else {
        print('Failed to load historiqueData');
      }
    } catch (e) {
      print('Error fetching historiqueData: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator on error
      });
    }
  }
  void fetchHistoriqueDataTotal() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/last-requests-total'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> historiqueDataList = List<Map<String, dynamic>>.from(jsonData);
        setState(() {
          historiqueDataTotal = historiqueDataList;
          _isLoading = false; // Hide loading indicator
        });
      } else {
        print('Failed to load historique Data');
      }
    } catch (e) {
      print('Error fetching historique Data: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator on error
      });
    }
  }

  void fetchVueDataLouvres() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/click-counter-louvres'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> clickcounter = List<Map<String, dynamic>>.from(jsonData);
        setState(() {
          VueDataLouvres = clickcounter;
          _isLoading = false; // Hide loading indicator
        });
      } else {
        print('Failed to load clickcounter');
      }
    } catch (e) {
      print('Error fetching clickcounter: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator on error
      });
    }
  }
  void fetchVueDataGuimet() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/click-counter-guimet'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> clickcounter = List<Map<String, dynamic>>.from(jsonData);
        setState(() {
          VueDataGuimet = clickcounter;
          _isLoading = false; // Hide loading indicator
        });
      } else {
        print('Failed to load clickcounter');
      }
    } catch (e) {
      print('Error fetching clickcounter: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator on error
      });
    }
  }
  void fetchVueDataTotal() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/click-counter-total'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> clickcounter = List<Map<String, dynamic>>.from(jsonData);
        setState(() {
          VueDataTotal = clickcounter;
          _isLoading = false; // Hide loading indicator
        });
      } else {
        print('Failed to load clickcounter');
      }
    } catch (e) {
      print('Error fetching clickcounter: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator on error
      });
    }
  }


  void fetchDataAndCalculatePieChartDataLouvres() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/image-links-louvres'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // Initialize a map to count occurrences of each type
        final Map<String, int> typeCounts = {};
        // Iterate through the JSON data to count occurrences of each type
        for (var entry in jsonData) {
          final type = entry['type'] as String;
          typeCounts[type] = (typeCounts[type] ?? 0) + 1;
        }
        int totalCount = typeCounts.values.reduce((value, element) => value + element);
        // Convert the map into the required format
        final List<Map<String, dynamic>> result = typeCounts.entries
            .map((entry) => {'type': entry.key, 'pourcentage': (entry.value/totalCount)*100})
            .toList();

        setState(() {
          _isLoading = false; // Hide loading indicator
          selectedDataPie1 = result;
        });
      } else {
        print('Failed to fetch image links');
      }
    } catch (e) {
      print('Error fetching image links: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator on error
      });
    }
  }


  void fetchDataAndCalculatePieChartDataGuimet() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/image-links-guimet'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // Initialize a map to count occurrences of each type
        final Map<String, int> typeCounts = {};
        // Iterate through the JSON data to count occurrences of each type
        for (var entry in jsonData) {
          final type = entry['type'] as String;
          typeCounts[type] = (typeCounts[type] ?? 0) + 1;
        }
        int totalCount = typeCounts.values.reduce((value, element) => value + element);
        // Convert the map into the required format
        final List<Map<String, dynamic>> result = typeCounts.entries
            .map((entry) => {'type': entry.key, 'pourcentage': (entry.value/totalCount)*100})
            .toList();

        setState(() {
          _isLoading = false; // Hide loading indicator
          selectedDataPie2 = result;
        });
      } else {
        print('Failed to fetch image links');
      }
    } catch (e) {
      print('Error fetching image links: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator on error
      });
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build loading indicator if data is still loading
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(), // Or any other loading indicator widget
      );
    }

    final chartPieChartColorsList2 = [
      const Color(0xFF8F46E9),
      const Color(0xFF6F28CB),
      const Color(0xFF2536A4),
      const Color(0xFF4A57C1)
    ];
    final chartPieChartColorsList3 = [
      const Color(0xFF8F46E9),
      const Color(0xFF6F28CB),
      const Color(0xFF2536A4),
      const Color(0xFF4A57C1)
    ];
    if (_model.dropDownValue == 'musée du Louvre') {
      sumOfViews = VueDataLouvres.map<int>((item) => item['nombresdevue'] as int).reduce((value, element) => value + element);
      selectedData1 = historiqueDataLouvres;
      selectedData2 = VueDataLouvres;
      selectedDataPie = selectedDataPie1;
    } else if (_model.dropDownValue == 'musée Guimet') {
      sumOfViews = VueDataGuimet.map<int>((item) => item['nombresdevue'] as int).reduce((value, element) => value + element);
      selectedData1 = historiqueDataGuimet;
      selectedData2 = VueDataGuimet;
      selectedDataPie = selectedDataPie2;
    } else if (_model.dropDownValue == 'Total') {
      selectedData1 = historiqueDataTotal;
      selectedData2 = VueDataTotal;
      sumOfViews = VueDataGuimet.map<int>((item) => item['nombresdevue'] as int).reduce((value, element) => value + element) + VueDataLouvres.map<int>((item) => item['nombresdevue'] as int).reduce((value, element) => value + element);
      Map<String, double> selectedDataMap = {};
      // Iterate through selectedDataPie1
      for (var data in selectedDataPie1) {
        if (selectedDataMap.containsKey(data['type'])) {
          // If type already exists in the map, update the percentage
          selectedDataMap[data['type']] =
              selectedDataMap[data['type']]! + data['pourcentage']! / 2;
        } else {
          // Otherwise, add the type to the map
          selectedDataMap[data['type']] = data['pourcentage']! / 2;
        }
      }
      // Iterate through selectedDataPie2
      for (var data in selectedDataPie2) {
        if (selectedDataMap.containsKey(data['type'])) {
          // If type already exists in the map, update the percentage
          selectedDataMap[data['type']] =
              selectedDataMap[data['type']]! + data['pourcentage']! / 2;
        } else {
          // Otherwise, add the type to the map
          selectedDataMap[data['type']] = data['pourcentage']! / 2;
        }
      }

      // Construct selectedDataPie array from the map
      List<Map<String, dynamic>> selectedDataPie3 = selectedDataMap.entries
          .map((entry) => {'type': entry.key, 'pourcentage': entry.value})
          .toList();
      selectedDataPie = selectedDataPie3;
    }




    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          iconTheme: IconThemeData(
              color: FlutterFlowTheme.of(context).primaryBackground),
          automaticallyImplyLeading: true,
          title: Align(
            alignment: const AlignmentDirectional(-1.0, -1.0),
            child: Text(
              'DASHBOARD',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    fontSize: 25.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 3.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    25.0, 50.0, 0.0, 50.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.5,
                                  child: Stack(
                                    children: [
                                      FlutterFlowLineChart(
                                        data: [
                                          FFLineChartData(
                                            xData: [1, 2, 3, 4, 5],  // Valeurs fixes pour l'axe X
                                            yData: [10, 20, 30, 40, 50],  // Valeurs fixes pour l'axe Y
                                            settings: LineChartBarData(
                                              color: FlutterFlowTheme.of(context).primary,
                                            ),
                                          ),
                                            // Ajoutez d'autres FFLineChartData si nécessaire
                                        ],
                                        chartStylingInfo: ChartStylingInfo(
                                          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                          borderColor: FlutterFlowTheme.of(context).secondaryText,
                                          borderWidth: 1.0,
                                        ),
                                        axisBounds: const AxisBounds(),
                                        xAxisLabelInfo: const AxisLabelInfo(
                                          title: 'JOURS',
                                          titleTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          ),
                                          showLabels: true,
                                          labelInterval: 10,
                                        ),
                                        yAxisLabelInfo: const AxisLabelInfo(
                                          title: 'NOMBRE DE VUES',
                                          titleTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0.6, 0.5),
                                        child: FlutterFlowChartLegendWidget(
                                          entries: [
                                            LegendEntry(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                'Joconde'),
                                            LegendEntry(Color(0xFF6F28CB),
                                                'Victoire de Samothrace'),
                                            LegendEntry(Color(0xFF2536A4),
                                                'Vénus de Milo'),
                                          ],
                                          width: 100,
                                          height: 50,
                                          textStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Poppins',
                                            letterSpacing: 0,
                                          ),
                                          textPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 0, 0),
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 5, 0),
                                          borderWidth: 1,
                                          borderColor: Colors.black,
                                          indicatorSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    return FlutterFlowDataTable<Map<String, dynamic>>(
                                      controller: _model.paginatedDataTableController2,
                                      data: selectedData1,
                                      columnsBuilder: (onSortChanged) => [

                                        DataColumn2(
                                          label: Text(
                                            'numero de requete',
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                            ),
                                          ),
                                        ),
                                        DataColumn2(
                                          label: Text(
                                            'oeuvres',
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                            ),
                                          ),
                                        ),
                                        DataColumn2(
                                          label: Text(
                                            'Date',
                                            style: TextStyle(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                            ),
                                          ),
                                        ),
                                      ],
                                      dataRowBuilder: (historiqueItem, historiqueIndex, selected, onSelectChanged) => DataRow(
                                        color: MaterialStateProperty.all(
                                          historiqueIndex % 2 == 0 ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primaryBackground,
                                        ),
                                        cells: [
                                          DataCell(
                                            Text(
                                              historiqueItem['numero de requete'].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              historiqueItem['oeuvres'],
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              historiqueItem['Date'],
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      paginated: false,
                                      selectable: false,
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      height: MediaQuery.of(context).size.height * 0.4,
                                      headingRowHeight: 56.0,
                                      dataRowHeight: 48.0,
                                      columnSpacing: 20.0,
                                      headingRowColor: FlutterFlowTheme.of(context).primary,
                                      borderRadius: BorderRadius.circular(8.0),
                                      addHorizontalDivider: true,
                                      addTopAndBottomDivider: false,
                                      hideDefaultHorizontalDivider: true,
                                      horizontalDividerColor: FlutterFlowTheme.of(context).secondaryBackground,
                                      horizontalDividerThickness: 1.0,
                                      addVerticalDivider: false,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ]
                        ).animateOnPageLoad(
                            animationsMap['columnOnPageLoadAnimation1']!),
                      ),
                      Align(
                        alignment:  AlignmentDirectional(0.14, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  50.0, 75.0, 0.0, 75.0),
                              child: Container(
                                width: 300.0,
                                height: 300.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x33000000),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(24.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.19),
                                      child: GradientText(
                                        '\n\nVues les 30 Derniers Jours',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 30.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        colors: [
                                          FlutterFlowTheme.of(context).primary,
                                          FlutterFlowTheme.of(context).secondary
                                        ],
                                        gradientDirection:
                                            GradientDirection.ltr,
                                        gradientType: GradientType.linear,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-0.03, -0.43),
                                      child: GradientText(
                                        '$sumOfViews',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 50.0,
                                              letterSpacing: 0.0,
                                            ),
                                        colors: [
                                          FlutterFlowTheme.of(context).primary,
                                          FlutterFlowTheme.of(context).secondary
                                        ],
                                        gradientDirection:
                                            GradientDirection.ltr,
                                        gradientType: GradientType.linear,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  50.0, 0.0, 0.0, 10.0),
                              child: FlutterFlowDropDown<String>(
                                controller: _model.dropDownValueController ??= FormFieldController<String>('Total'),
                                options: const [
                                  'Total',
                                  'musée du Louvre',
                                  'musée Guimet'
                                ],
                                onChanged: (val) => setState(() => _model.dropDownValue = val),
                                width: 300.0,
                                height: 56.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Total',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderWidth: 2.0,
                                borderRadius: 8.0,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 4.0, 16.0, 4.0),
                                hidesUnderline: true,
                                isOverButton: true,
                                isSearchable: true,
                                isMultiSelect: false,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(60.0, 20.0, 0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    // Définition des données fixes
                                    return FlutterFlowDataTable<Map<String, dynamic>>(
                                      controller: _model.paginatedDataTableController1,
                                      data: selectedData2,
                                      columnsBuilder: (onSortChanged) => [
                                        DataColumn2(
                                          label: DefaultTextStyle.merge(
                                            softWrap: true,
                                            child: Text(
                                              'LES PLUS VUES',
                                              style: FlutterFlowTheme.of(context).labelLarge.override(
                                                fontFamily: 'Poppins',
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      dataRowBuilder: (row, index, selected, onSelectChanged) => DataRow(
                                        color: MaterialStateProperty.all(
                                          index % 2 == 0 ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primaryBackground,
                                        ),
                                        cells: [
                                          DataCell(
                                            Text(
                                              '${row['oeuvres']} - ${row['nombresdevue']} vue${row['nombresdevue'] != 1 ? 's' : ''}',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Poppins',
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      paginated: false,
                                      selectable: false,
                                      width: 300,
                                      height: MediaQuery.sizeOf(context).height * 0.4,
                                      headingRowHeight: 56.0,
                                      dataRowHeight: 48.0,
                                      columnSpacing: 20.0,
                                      headingRowColor: FlutterFlowTheme.of(context).primary,
                                      borderRadius: BorderRadius.circular(8.0),
                                      addHorizontalDivider: true,
                                      addTopAndBottomDivider: false,
                                      hideDefaultHorizontalDivider: true,
                                      horizontalDividerColor: FlutterFlowTheme.of(context).secondaryBackground,
                                      horizontalDividerThickness: 1.0,
                                      addVerticalDivider: false,
                                    );
                                  },
                                ),
                              ),
                            ),

                          ],
                        ).animateOnPageLoad(
                            animationsMap['columnOnPageLoadAnimation2']!),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 30.0, 45.0, 0.0),
                                child: Container(
                                  width: 370.0,
                                  height: 400.0,
                                  child: Stack(
                                    children: [
                                      FlutterFlowPieChart(
                                        data: FFPieChartData(
                                          values: selectedDataPie.map((data) => data['pourcentage'] as double).toList(),
                                          colors: chartPieChartColorsList2,
                                          radius: [100.0],
                                        ),
                                        donutHoleRadius: 70.0,
                                        donutHoleColor: Colors.transparent,
                                        sectionLabelType:
                                            PieChartSectionLabelType.percent,
                                        sectionLabelStyle:
                                            FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color:
                                                      FlutterFlowTheme.of(context)
                                                          .primaryBackground,
                                                  letterSpacing: 0.0,
                                                ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(1.0, 1.0),
                                        child: FlutterFlowChartLegendWidget(
                                          entries: List.generate(
                                              random_data.randomInteger(
                                                  0, 0),
                                                  (index) =>
                                                  random_data.randomString(
                                                    1,
                                                    10,
                                                    true,
                                                    false,
                                                    false,
                                                  ))
                                              .asMap()
                                              .entries
                                              .map(
                                                (label) => LegendEntry(
                                              chartPieChartColorsList2[label
                                                  .key %
                                                  chartPieChartColorsList2
                                                      .length],
                                              label.value,
                                            ),
                                          )
                                              .toList(),
                                          width: 100,
                                          height: 50,
                                          textStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Poppins',
                                            letterSpacing: 0,
                                          ),
                                          textPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 0, 0),
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 5, 0),
                                          borderWidth: 1,
                                          borderColor: Colors.black,
                                          indicatorSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1, -1),
                              child: Padding(
                                padding:  EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 45.0, 0.0),
                                child: Container(
                                  width: 370.0,
                                  height: 400.0,
                                  child: FlutterFlowPieChart(
                                    data: FFPieChartData(
                                      // Remplacez les valeurs générées aléatoirement par des valeurs fixes
                                      values: [10, 20, 30, 40, 50],
                                      colors: chartPieChartColorsList2,
                                      radius: [100.0],
                                    ),
                                    donutHoleRadius: 70.0,
                                    donutHoleColor: Colors.transparent,
                                    sectionLabelType:
                                        PieChartSectionLabelType.percent,
                                    sectionLabelStyle:
                                        FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              letterSpacing: 0.0,
                                            ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ).animateOnPageLoad(
                            animationsMap['columnOnPageLoadAnimation3']!),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
