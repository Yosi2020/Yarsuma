import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Color> gradientColors = [
  Colors.green,
  Color(0xFF9DCEFF),
];
LineChartData activityDataDay() {
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
    maxX: 2,
    minY: 0,
    maxY: 50,
    lineBarsData: [
      LineChartBarData(
        spots:  [
          FlSpot(1, 36.5),
          FlSpot(2, 38.2),
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