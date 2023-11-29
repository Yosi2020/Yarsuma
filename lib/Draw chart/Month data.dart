import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Color> gradientColors = [
  Colors.green,
  Color(0xFF9DCEFF),
];
LineChartData activityDataMonth() {
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
    maxX: 30,
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
          FlSpot(8, 36.5),
          FlSpot(9, 38.2),
          FlSpot(10, 36.6),
          FlSpot(11, 37),
          FlSpot(12, 36),
          FlSpot(13, 38),
          FlSpot(14, 37),
          FlSpot(15, 36),
          FlSpot(16, 38),
          FlSpot(17, 38.4),
          FlSpot(18, 37.2),
          FlSpot(18, 37.9),
          FlSpot(20, 39),
          FlSpot(21, 38),
          FlSpot(22, 36.5),
          FlSpot(23, 38.2),
          FlSpot(24, 37),
          FlSpot(25, 39),
          FlSpot(26, 36.9),
          FlSpot(27, 38.2),
          FlSpot(28, 37.3),
          FlSpot(29, 37.2),
          FlSpot(30, 38.3),

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