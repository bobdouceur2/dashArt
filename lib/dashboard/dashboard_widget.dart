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
  late DashboardModel _model;

  List<Map<String, dynamic>> historiqueDataLouvres = [];
  List<Map<String, dynamic>> VueDataLouvres = [];

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
    fetchVueDataLouvres();
  }
  void fetchHistoriqueDataLouvres() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/last-requests-louvres'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> historiqueDataList = List<Map<String, dynamic>>.from(jsonData);
        setState(() {
          historiqueDataLouvres = historiqueDataList;
        });
      } else {
        print('Failed to load historiqueData');
      }
    } catch (e) {
      print('Error fetching historiqueData: $e');
    }
  }

  void fetchVueDataLouvres() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/click-counter-louvres'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Map<String, dynamic>> clickcounter = List<Map<String, dynamic>>.from(jsonData);
        setState(() {
          VueDataLouvres = clickcounter;
        });
      } else {
        print('Failed to load clickcounter');
      }
    } catch (e) {
      print('Error fetching clickcounter: $e');
    }
  }



  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    int sumOfViews = VueDataLouvres.map<int>((item) => item['nombresdevue'] as int).reduce((value, element) => value + element);
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
                        alignment: const AlignmentDirectional(0.0, 0.0),
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
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.5,
                                  child: FlutterFlowLineChart(
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
                                      //labelInterval: 10,
                                    ),
                                    yAxisLabelInfo: const AxisLabelInfo(
                                      title: 'NOMBRE DE VUES',
                                      titleTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
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
                                      data: historiqueDataLouvres,
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


                          ]).animateOnPageLoad(
                            animationsMap['columnOnPageLoadAnimation1']!),
                      ),

                      Align(
                        alignment: const AlignmentDirectional(0.14, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  60.0, 75.0, 0.0, 75.0),
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  60.0, 0.0, 0.0, 10.0),
                              child: FlutterFlowDropDown<String>(
                                controller: _model.dropDownValueController ??=
                                    FormFieldController<String>(null),
                                options: const [
                                  '... au musée du Louvre',
                                  '... au musée du Quai Branly'
                                ],
                                onChanged: (val) =>
                                    setState(() => _model.dropDownValue = val),
                                width: 300.0,
                                height: 56.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'TOP 5 des plus vus...',
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
                                isSearchable: false,
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
                                      data: VueDataLouvres,
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
                                      width: MediaQuery.sizeOf(context).width * 0.2,
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
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 30.0, 45.0, 0.0),
                                child: SizedBox(
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
                                        PieChartSectionLabelType.value,
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
                            Align(
                              alignment: const AlignmentDirectional(1.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 40.0, 45.0, 0.0),
                                child: SizedBox(
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
                                        PieChartSectionLabelType.value,
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
