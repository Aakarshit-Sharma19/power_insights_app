import 'package:flutter/material.dart';
import 'package:power_insights/routes.dart';

class InsightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.dailyInsights);
            },
            child: Text('Daily Insights')),
        TextButton(onPressed: () {}, child: Text('Monthly Insights')),
      ],
    );
  }
}
