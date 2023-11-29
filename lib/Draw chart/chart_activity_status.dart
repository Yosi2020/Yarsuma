//https://www.youtube.com/watch?v=4gkt5qDBq4w&list=RDCMUCDCFIqDZ1QUqivxVFQDxS0w&index=3

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Color> gradientColors = [
  Colors.green,
  Color(0xFF9DCEFF),
];
LineChartData activityData() {
  return LineChartData(
    gridData: FlGridData(
      show: false,
      drawVerticalLine: true,
    ),
    titlesData: FlTitlesData(
      show: false,
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 1,
    maxX: 7,
    minY: 0,
    maxY: 50,
    lineBarsData: [
      LineChartBarData(
        spots:  [
          FlSpot(1, 36.5),
          FlSpot(2, 38.2),
          FlSpot(3, 38.4),
          FlSpot(4, 38.4),
          FlSpot(5, 40.5),
          FlSpot(6, 42),
          FlSpot(7, 37),

        ],
        isCurved: false,
        colors: [Colors.white70],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: [Color(0xFF00BF6D).withBlue(187)],
        ),
      ),
    ],
  );
}