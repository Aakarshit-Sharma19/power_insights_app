import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:power_insights/components/insights_chart.dart';
import 'package:power_insights/models/power_consumption.dart';
import 'package:power_insights/utilities/insights.dart';

class DailyInsightsScreen extends StatefulWidget {
  @override
  _DailyInsightsScreenState createState() => _DailyInsightsScreenState();
}

class _DailyInsightsScreenState extends State<DailyInsightsScreen> {
  _DailyInsightsScreenState() {
    consideredDate = DateTime.now();
    series = DailyConsumptionSeries([]);
  }
  DateTime consideredDate;
  DailyConsumptionSeries series;

  @override
  void initState() {
    super.initState();
    getDailyData(consideredDate.month, consideredDate.year)
        .then((consumptionData) {
      if (consumptionData.length == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'No data present for ${consideredDate.month}/${consideredDate.year}'),
          ),
        );
      }
      setState(() {
        series = DailyConsumptionSeries(consumptionData);
      });
    });
  }

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
                          initialDate: consideredDate,
                          firstDate: DateTime(2021, 6),
                          lastDate: DateTime.now())
                      .then((selectedDate) {
                    if (selectedDate != null) {
                      getDailyData(consideredDate.month, consideredDate.year)
                          .then((consumptionData) {
                        if (consumptionData.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'No data present for ${selectedDate.month}/${selectedDate.year}'),
                            ),
                          );
                        }
                        setState(() {
                          consideredDate = selectedDate;
                          series = DailyConsumptionSeries(
                              consumptionData as List<PowerConsumption>);
                        });
                      });
                    }
                  });
                },
                child: Text('Select Year and Month'),
              ),
              Text('Showing for ${consideredDate.month}/${consideredDate.year}')
            ],
          ),
          Expanded(
            // height: 500,
            child: InsightsChart(series),
          )
        ],
      ),
    );
  }
}

class DailyConsumptionSeries implements ConsumptionSeries {
  final List<PowerConsumption> data;
  DailyConsumptionSeries(this.data);
  List<charts.Series<PowerConsumption, DateTime>> getData() {
    print(data);
    return [
      new charts.Series<PowerConsumption, DateTime>(
        id: 'power_consumption',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PowerConsumption consumption, _) => consumption.date,
        measureFn: (PowerConsumption consumption, _) => consumption.consumption,
        data: data,
      )
    ];
  }
}
