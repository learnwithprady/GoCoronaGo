import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:go_corona_go/models/WorldStats_Model.dart';
import 'package:go_corona_go/themes/dark_color.dart';
import 'package:go_corona_go/themes/theme.dart';

class ChartStats extends StatefulWidget {
  final WorldStats globalStats;
  const ChartStats(this.globalStats);
  @override
  _ChartStatsState createState() => _ChartStatsState();
}

class _ChartStatsState extends State<ChartStats> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  List<CircularStackEntry> getChartData(WorldStats stats) {
    return <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
              stats.totalConfirmed.toDouble(), DarkColor.active,
              rankKey: 'Active'),
          new CircularSegmentEntry(
              stats.totalRecovered.toDouble(), DarkColor.recovered,
              rankKey: 'Recovered'),
          new CircularSegmentEntry(
              stats.totalDeaths.toDouble(), DarkColor.death,
              rankKey: 'Death'),
        ],
        rankKey: 'Covid19 Stats',
      ),
    ];
  }

//  List<CircularStackEntry> data = ;

  @override
  Widget build(BuildContext context) {
    final stats = widget.globalStats;
    final recoveredCases = stats.totalRecovered;
    final deathCases = stats.totalDeaths;
    final confirmedCases = stats.totalConfirmed;
    final activeCases = confirmedCases - deathCases - recoveredCases;

    return Column(
      children: <Widget>[
        new AnimatedCircularChart(
          key: _chartKey,
          size: const Size(250.0, 250.0),
          initialChartData: getChartData(stats),
          chartType: CircularChartType.Pie,
          edgeStyle: SegmentEdgeStyle.round,
          duration: Duration(milliseconds: 1000),
          labelStyle: AppTheme.subTitleStyle,
        ),
        Container(
          color: DarkColor.background,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'Total Cases:',
                  style: AppTheme.totalConfirmedCasesLabel,
                ),
                new Text(confirmedCases.toString(),
                    style: AppTheme.statsCountNumber
                        .copyWith(color: DarkColor.confirmedCasesBox)),
              ]),
        ),
        Card(
          elevation: 6.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            color: DarkColor.background,
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.radio_button_checked,
                          color: Colors.orange,
                        ),
                        Container(
                          transform: Matrix4.translationValues(-5.0, 1.0, 0.0),
                          child: new Text(
                            'Active',
                            style: AppTheme.legendsStyle.copyWith(
                                backgroundColor: DarkColor.active,
                                letterSpacing: 1),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.radio_button_checked,
                          color: Colors.red,
                        ),
                        Container(
                          transform: Matrix4.translationValues(-5.0, 1.0, 0.0),
                          child: new Text(
                            'Death',
                            style: AppTheme.legendsStyle.copyWith(
                                backgroundColor: DarkColor.death,
                                letterSpacing: 1),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.radio_button_checked,
                          color: Colors.lightGreen,
                        ),
                        Container(
                          transform: Matrix4.translationValues(-5.0, 1.0, 0.0),
                          child: new Text(
                            'Recovered',
                            style: AppTheme.legendsStyle.copyWith(
                                backgroundColor: DarkColor.recovered,
                                letterSpacing: 1),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Text(
                        activeCases.toString(),
                        style: AppTheme.statsCountNumber
                            .copyWith(color: DarkColor.active),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        deathCases.toString(),
                        style: AppTheme.statsCountNumber
                            .copyWith(color: DarkColor.death),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(recoveredCases.toString(),
                          style: AppTheme.statsCountNumber
                              .copyWith(color: DarkColor.recovered)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}