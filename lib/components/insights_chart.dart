import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:power_insights/models/power_consumption.dart';

class InsightsChart extends StatelessWidget {
  final bool animate;
  final List<charts.Series<PowerConsumption, DateTime>> consumptionData;
  InsightsChart(this.consumptionData, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      consumptionData,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

