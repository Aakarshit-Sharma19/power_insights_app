import 'package:flutter/material.dart';
import 'package:power_insights/components/insights_chart.dart';
import 'package:power_insights/models/power_consumption.dart';
import 'package:power_insights/utilities/insights.dart';

class MonthlyInsightsScreen extends StatefulWidget {
  @override
  _MonthlyInsightsScreenState createState() => _MonthlyInsightsScreenState();
}

class _MonthlyInsightsScreenState extends State<MonthlyInsightsScreen> {
  _MonthlyInsightsScreenState() {
    consideredDate = DateTime.now();
    consumptionData = [];
  }

  DateTime consideredDate;
  List<MonthlyPowerConsumption> consumptionData;

  @override
  void initState() {
    super.initState();
    getMonthlyData(consideredDate.year).then((consumptionData) {
      if (consumptionData.length == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No data present for ${consideredDate.year}'),
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
        title: Text('Monthly Statistics'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: consideredDate,
                          firstDate: DateTime(2021, 6),
                          lastDate: DateTime.now())
                      .then((selectedDate) {
                    if (selectedDate != null) {
                      getMonthlyData(selectedDate.year).then((consumptionData) {
                        if (consumptionData.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'No data present for {selectedDate.year}'),
                            ),
                          );
                        }
                        setState(() {
                          this.consumptionData =
                              consumptionData as List<MonthlyPowerConsumption>;
                          consideredDate = selectedDate;
                        });
                      });
                    }
                  });
                },
                child: Text('Select Year and Month'),
              ),
              Text('Showing for ${consideredDate.year}')
            ],
          ),
          Expanded(
            // height: 500,
            child: InsightsChart(parseMonthlyData(consumptionData)),
          )
        ],
      ),
    );
  }
}
