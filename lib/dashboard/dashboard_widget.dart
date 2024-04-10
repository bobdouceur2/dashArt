import 'package:dash_art/oeuvres_louvres/oeuvres_louvres_widget.dart';
import 'package:fl_chart/fl_chart.dart';
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
  List<Map<String, dynamic>> FirstPieDataLouvres = [];
  List<Map<String, dynamic>> FirstPieDataGuimet = [];
  List<Map<String, dynamic>> FirstPieDataSelector = [];
  List<Map<String, dynamic>> selectedData1 = [];
  List<Map<String, dynamic>> selectedData2 = [];
  List<Map<String, dynamic>> SecondPieDataLouvres = [];
  List<Map<String, dynamic>> SecondPieDataGuimet = [];
  List<Map<String, dynamic>> SecondPieDataSelector = [];
  List<List<DateTime>> xSelector = [];
  List<List<int>> ySelector = [];
  List<List<DateTime>> xLouvres = [];
  List<List<int>> yLouvres = [];
  List<List<DateTime>> xGuimet = [];
  List<List<int>> yGuimet = [];


  int sumOfViews = 0;
  String dropDownValueController = 'Total';

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
    fetchCalculateFirstPieDataLouvres();
    fetchCalculateFirstPieDataGuimet();
    fetchAndCountClickSecondPieLouvres();
    fetchAndCountClickSecondPieGuimet();
    fetchLineDataLouvres();
    fetchLineDataGuimet();

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


  void fetchCalculateFirstPieDataLouvres() async {
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
          FirstPieDataLouvres = result;
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


  void fetchCalculateFirstPieDataGuimet() async {
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
          FirstPieDataGuimet = result;
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


  void fetchAndCountClickSecondPieGuimet() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      // Fetch data from the first endpoint
      final clickCounterResponse = await http.get(
          Uri.parse('http://localhost:3000/click-counter-guimet'));
      final clickCounterData = json.decode(clickCounterResponse.body) as List<
          dynamic>;

      // Fetch data from the second endpoint
      final imageLinksResponse = await http.get(
          Uri.parse('http://localhost:3000/image-links-guimet'));
      final imageLinksData = json.decode(imageLinksResponse.body) as List<
          dynamic>;

      // Count the number of timestamps by type
      final Map<String, int> typeCounts = {};
      for (var artwork in clickCounterData) {
        final String artworkTitle = artwork['oeuvres'] as String;
        final int artworkViews = artwork['nombresdevue'] as int;
        final String? artworkType = imageLinksData
            .firstWhere((element) => element['titre'] == artworkTitle,
            orElse: () => {})['type'] as String?;
        if (artworkType != null) {
          typeCounts[artworkType] =
              (typeCounts[artworkType] ?? 0) + artworkViews;
        }
      }
      int totalViews = typeCounts.values.fold(0, (previousValue, element) => previousValue + element);
      List<Map<String, dynamic>> result = typeCounts.entries.map((entry) {
        return {
          'type': entry.key,
          'pourcentage': (entry.value / totalViews) * 100, // Calculate percentage
        };
      }).toList();

      setState(() {
        _isLoading = false; // Hide loading indicator
        SecondPieDataGuimet = result;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator on error
      });
    }
  }

  void fetchAndCountClickSecondPieLouvres() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      // Fetch data from the first endpoint
      final clickCounterResponse = await http.get(
          Uri.parse('http://localhost:3000/click-counter-louvres'));
      final clickCounterData = json.decode(clickCounterResponse.body) as List<
          dynamic>;

      // Fetch data from the second endpoint
      final imageLinksResponse = await http.get(
          Uri.parse('http://localhost:3000/image-links-louvres'));
      final imageLinksData = json.decode(imageLinksResponse.body) as List<
          dynamic>;

      // Count the number of timestamps by type
      final Map<String, int> typeCounts = {};
      for (var artwork in clickCounterData) {
        final String artworkTitle = artwork['oeuvres'] as String;
        final int artworkViews = artwork['nombresdevue'] as int;
        final String? artworkType = imageLinksData
            .firstWhere((element) => element['titre'] == artworkTitle,
            orElse: () => {})['type'] as String?;
        if (artworkType != null) {
          typeCounts[artworkType] =
              (typeCounts[artworkType] ?? 0) + artworkViews;
        }
      }
      int totalViews = typeCounts.values.fold(0, (previousValue, element) => previousValue + element);

      List<Map<String, dynamic>> result = typeCounts.entries.map((entry) {
        return {
          'type': entry.key,
          'pourcentage': (entry.value / totalViews) * 100, // Calculate percentage
        };
      }).toList();

      setState(() {
        _isLoading = false; // Hide loading indicator
        SecondPieDataLouvres = result;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator on error
      });
    }
  }


  void fetchLineDataLouvres() async {
    final response = await http.get(Uri.parse('http://localhost:3000/timestamps-louvres'));

    if (response.statusCode == 200) {
      final dataMap = json.decode(response.body);
      int counter = 0;
      dataMap.forEach((art, timestamps) {
        if (counter < 5) {
          counter++;
          // Map to hold count of timestamps for each date
          final Map<DateTime, int> timestampCounts = {};
          // Convert timestamps to DateTime objects and count occurrences for each date
          timestamps.map((timestamp) =>
              DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal()).forEach((
              dateTime) {
            final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
            timestampCounts.update(
                date, (value) => value + 1, ifAbsent: () => 1);
          });

          // Prepare X data (dates) and Y data (counts) for the art
          final List<DateTime> xData = timestampCounts.keys.toList();
          final List<int> yData = timestampCounts.values.toList();

          // Add xData and yData to the selector lists
          xLouvres.add(xData);
          yLouvres.add(yData);
        }
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  void fetchLineDataGuimet() async {
    final response = await http.get(Uri.parse('http://localhost:3000/timestamps-guimet'));

    if (response.statusCode == 200) {
      final dataMap = json.decode(response.body);
      int counter = 0;
      dataMap.forEach((art, timestamps) {
        if (counter < 5) {
          counter++;
          // Map to hold count of timestamps for each date
          final Map<DateTime, int> timestampCounts = {};
          // Convert timestamps to DateTime objects and count occurrences for each date
          timestamps.map((timestamp) =>
              DateTime.fromMillisecondsSinceEpoch(timestamp)).forEach((
              dateTime) {
            timestampCounts.update(
                dateTime, (value) => value + 1, ifAbsent: () => 1);
          });

          // Prepare X data (dates) and Y data (counts) for the art
          final List<DateTime> xData = timestampCounts.keys.toList();
          final List<int> yData = timestampCounts.values.toList();

          // Add xData and yData to the selector lists
          xGuimet.add(xData);
          yGuimet.add(yData);
        }
      });
    } else {
      throw Exception('Failed to fetch data');
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

    void updateSelectedDataMap(List<Map<String, dynamic>> data, Map<String, double> selectedDataMap) {
      for (var dataPoint in data) {
        var type = dataPoint['type'];
        var percentage = dataPoint['pourcentage']! / 2;
        if (selectedDataMap.containsKey(type)) {
          selectedDataMap[type] = selectedDataMap[type]! + percentage;
        } else {
          selectedDataMap[type] = percentage;
        }
      }
    }
    if (_model.dropDownValue == 'musée du Louvre') {
      sumOfViews = VueDataLouvres.map<int>((item) => item['nombresdevue'] as int).reduce((value, element) => value + element);
      selectedData1 = historiqueDataLouvres;
      selectedData2 = VueDataLouvres;
      FirstPieDataSelector = FirstPieDataLouvres;
      SecondPieDataSelector = SecondPieDataLouvres;
      xSelector=xLouvres;
      ySelector=yLouvres;
      print(xSelector);
      print(ySelector);
    } else if (_model.dropDownValue == 'musée Guimet') {
      sumOfViews = VueDataGuimet.map<int>((item) => item['nombresdevue'] as int).reduce((value, element) => value + element);
      selectedData1 = historiqueDataGuimet;
      selectedData2 = VueDataGuimet;
      FirstPieDataSelector = FirstPieDataGuimet;
      SecondPieDataSelector = SecondPieDataGuimet;
      xSelector=xGuimet;
      ySelector=yGuimet;
      print(xSelector);
      print(ySelector);
    } else if (_model.dropDownValue == 'Total') {
      selectedData1 = historiqueDataTotal;
      selectedData2 = VueDataTotal;
      sumOfViews =
          VueDataGuimet.map<int>((item) => item['nombresdevue'] as int).reduce((
              value, element) => value + element) +
              VueDataLouvres.map<int>((item) => item['nombresdevue'] as int)
                  .reduce((value, element) => value + element);

      Map<String, double> selectedDataMap1 = {};
      Map<String, double> selectedDataMap2 = {};
      // Update selectedDataMap1 and selectedDataMap2
      updateSelectedDataMap(FirstPieDataLouvres, selectedDataMap1);
      updateSelectedDataMap(FirstPieDataGuimet, selectedDataMap1);
      updateSelectedDataMap(SecondPieDataLouvres, selectedDataMap2);
      updateSelectedDataMap(SecondPieDataGuimet, selectedDataMap2);

      // Convert selectedDataMap1 and selectedDataMap2 to lists
      List<Map<String, dynamic>> result1 = selectedDataMap1.entries
          .map<Map<String, dynamic>>((entry) => {'type': entry.key, 'pourcentage': entry.value})
          .toList()
        ..sort((a, b) => a['type'].compareTo(b['type']));

      List<Map<String, dynamic>> result2 = selectedDataMap2.entries
          .map<Map<String, dynamic>>((entry) => {'type': entry.key, 'pourcentage': entry.value})
          .toList()
        ..sort((a, b) => a['type'].compareTo(b['type']));
      FirstPieDataSelector = result1 ;
      SecondPieDataSelector = result2 ;
      xSelector=xLouvres;
      ySelector=yLouvres;

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
                                              xData: [1,2,3,4,5,6,7,8,9,10],
                                              yData: [0,5,5,6,7,7,7,8,9,11], // Valeurs fixes pour l'axe Y
                                              settings: LineChartBarData(
                                                color: FlutterFlowTheme.of(context).primary,
                                              ),
                                            ),

                                            FFLineChartData(
                                              xData: [1,2,3,4,5,6,7,8,9,10],
                                              yData: [0,3,4,4,5,6,6,7,7,7],
                                              settings: LineChartBarData(
                                                color: Colors.red,
                                              ),
                                            ),

                                            FFLineChartData(
                                              xData: [1,2,3,4,5,6,7,8,9,10],
                                              yData: [0,4,9,9,11,12,12,14,17,19], // Valeurs fixes pour l'axe Y
                                              settings: LineChartBarData(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],

                                          chartStylingInfo: ChartStylingInfo(
                                            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                            borderColor: FlutterFlowTheme.of(context).secondaryText,
                                            borderWidth: 1.0,
                                          ),

                                          axisBounds: const AxisBounds(),
                                          xAxisLabelInfo: const AxisLabelInfo(
                                            title: "Jours du Mois d'Avril",
                                            titleTextStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                            showLabels: true,
                                            labelInterval: 1,
                                          ),
                                          yAxisLabelInfo: const AxisLabelInfo(
                                            title: 'NOMBRE DE VUES',
                                            titleTextStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                            showLabels: true,
                                          ),



                                        ),

                                        Align(
                                          alignment: AlignmentDirectional(1.45, 1.15),
                                          child: FlutterFlowChartLegendWidget(
                                            entries: [
                                              LegendEntry(FlutterFlowTheme.of(context).primary, 'Joconde'),
                                              LegendEntry(Colors.red, 'Victoire de Samothrace'),
                                              LegendEntry(Colors.blue, 'Vénus de Milo'),
                                            ],
                                            width: 300,
                                            height: 160,
                                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Poppins',
                                              letterSpacing: 0,
                                            ),
                                            textPadding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                            borderWidth: 1,
                                            borderColor: Colors.transparent,
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
                                              'Numero de requete',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                              ),
                                            ),
                                          ),
                                          DataColumn2(
                                            label: Text(
                                              'Oeuvres',
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
                                controller: _model.dropDownValueController ??= FormFieldController<String>(_model.dropDownValue = 'Total'),
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
                                    0.0, 0.0, 45.0, 0.0),
                                child: Container(
                                  width: 370.0,
                                  height: 400.0,
                                  child: Stack(
                                    children: [
                                      FlutterFlowPieChart(
                                        data: FFPieChartData(
                                          values: FirstPieDataSelector.map((data) => data['pourcentage'] as double).toList(),
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
                                        alignment: AlignmentDirectional(-1.0, 4),
                                        child: FlutterFlowChartLegendWidget(
                                          entries:[
                                            // Title entry
                                            LegendEntry(
                                              Colors.transparent,
                                              "Pourcentage de type d'oeuvre au musée",
                                            ),
                                            ...FirstPieDataSelector.map((data) {
                                              final String type = data['type'] as String;
                                              final Color color = chartPieChartColorsList2[FirstPieDataSelector.indexOf(data) % chartPieChartColorsList2.length];
                                              //final String Text = "Pourcentage de type d'oeuvre";
                                              return LegendEntry(
                                                color,
                                                type,
                                              );
                                            }).toList(),
                                          ],
                                          width: 400,
                                          height: 250,
                                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Poppins',
                                            letterSpacing: 0,
                                          ),
                                          textPadding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                          borderWidth: 1,
                                          borderColor: Colors.transparent,
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
                                  child: Stack(
                                    children: [
                                      FlutterFlowPieChart(
                                        data: FFPieChartData(
                                          values: SecondPieDataSelector.map((data) => data['pourcentage'] as double).toList(),
                                          colors: chartPieChartColorsList2,
                                          radius: [100.0],
                                        ),
                                        donutHoleRadius: 70.0,
                                        donutHoleColor: Colors.transparent,
                                        sectionLabelType: PieChartSectionLabelType.percent,
                                        sectionLabelStyle: FlutterFlowTheme.of(context).headlineSmall.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(-1.0, 2.75),
                                        child: FlutterFlowChartLegendWidget(
                                          entries: [
                                            // Title entry
                                            LegendEntry(
                                              Colors.transparent,
                                              "Pourcentage de Vue par type d'oeuvre",
                                            ),
                                            ...SecondPieDataSelector.map((data) {
                                              final String type = data['type'] as String;
                                              final Color color = chartPieChartColorsList2[SecondPieDataSelector.indexOf(data) % chartPieChartColorsList2.length];
                                              return LegendEntry(
                                                color,
                                                type,
                                              );
                                            }).toList(),
                                          ],
                                          width: 400,
                                          height: 200,
                                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Poppins',
                                            letterSpacing: 0,
                                          ),
                                          textPadding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                          borderWidth: 1,
                                          borderColor: Colors.transparent,
                                          indicatorSize: 10,
                                        ),
                                      ),
                                    ],
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