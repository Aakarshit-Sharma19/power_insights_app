import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:power_insights/components/insights_chart.dart';
import 'package:power_insights/models/power_consumption.dart';

class DailyInsightsScreen extends StatefulWidget {
  @override
  _DailyInsightsScreenState createState() => _DailyInsightsScreenState();
}

class _DailyInsightsScreenState extends State<DailyInsightsScreen> {
  _DailyInsightsScreenState() {
    consideredDate = DateTime.now();
    series = DailyConsumptionSeries();
  }
  DateTime consideredDate;
  DailyConsumptionSeries series;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Statistics'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  showMonthPicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021, 6),
                          lastDate: DateTime.now())
                      .then((selectedDate) {
                    this.setState(() {
                      this.consideredDate = selectedDate;
                    });
                  });
                },
                child: Text('Select Year and Month'),
              ),
              Text('Showing for ${consideredDate.month}/${consideredDate.year}')
            ],
          ),
          Expanded(
              // height: 500,
              child: InsightsChart(series))
        ],
      ),
    );
  }
}

class DailyConsumptionSeries implements ConsumptionSeries {
  List<charts.Series<PowerConsumption, DateTime>> getData() {
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
        domainFn: (PowerConsumption consumption, _) => consumption.time,
        measureFn: (PowerConsumption consumption, _) => consumption.consumption,
        data: data,
      )
    ];
  }
}
