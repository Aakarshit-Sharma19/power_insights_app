import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class InsightsScreen extends StatefulWidget {
  @override
  _InsightsScreenState createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  @override
  Widget build(BuildContext context) {
    return SimpleTimeSeriesChart(SimpleTimeSeriesChart._createSampleData());
  }
}

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<PowerConsumption, DateTime>> _createSampleData() {
    List<PowerConsumption> data = [];
    Random random = new Random();
    for (int i = 0; i < 10; i++) {
      data.add(
          new PowerConsumption(new DateTime(2021, 3, i), random.nextInt(50)));
    }
    return [
      new charts.Series<PowerConsumption, DateTime>(
        id: 'Power in KW',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PowerConsumption sales, _) => sales.time,
        measureFn: (PowerConsumption sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class PowerConsumption {
  final DateTime time;
  final int sales;

  PowerConsumption(this.time, this.sales);
}
