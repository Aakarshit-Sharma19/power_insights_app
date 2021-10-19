
import 'package:flutter/material.dart';
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
    consumptionData = [];
  }

  DateTime consideredDate;
  List<PowerConsumption> consumptionData;

  @override
  void initState() {
    super.initState();
    getDailyData(consideredDate.month, consideredDate.year)
        .then((consumptionData) {
      if (consumptionData.length == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'No data present for ${consideredDate.month}/${consideredDate
                    .year}'),
          ),
        );
      }
      setState(() {
        this.consumptionData = consumptionData;
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
                      getDailyData(selectedDate.month, selectedDate.year)
                          .then((consumptionData) {
                        if (consumptionData.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'No data present for ${selectedDate
                                      .month}/${selectedDate.year}'),
                            ),
                          );
                        }
                        setState(() {
                          this.consumptionData =
                          consumptionData as List<PowerConsumption>;
                          consideredDate = selectedDate;
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
              child: InsightsChart(getData(consumptionData)),
          )
        ],
      ),
    );
  }
}
