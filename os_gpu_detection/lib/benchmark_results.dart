import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BenchMark_Results extends StatelessWidget {
  final String selectedFileName;
  final String fileExt;
  final String filePath;
  final String submittedKey;
  final String outputFilePath;

  BenchMark_Results({
    required this.selectedFileName,
    required this.fileExt,
    required this.filePath,
    required this.submittedKey,
    required this.outputFilePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Benchmark Results'),
      ),
      body: Row(
        children: [
          // Bar Chart on the left
          Container(
            width: 700,
            height: 500,
            child: BarChart(
              BarChartData(
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [
                    BarChartRodData(fromY: 0, color: Colors.red, toY: 20),
                  ]),
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData(fromY: 0, color: Colors.blue, toY: 10),
                  ]),
                  BarChartGroupData(x: 2, barRods: [
                    BarChartRodData(fromY: 0, color: Colors.orange, toY: 30),
                  ]),
                  BarChartGroupData(x: 3, barRods: [
                    BarChartRodData(fromY: 0, color: Colors.yellow, toY: 50),
                  ]),
                ],
                // titlesData: FlTitlesData(
                //   leftTitles: AxisTitle(showTitles: true),
                // ),
                borderData: FlBorderData(show: true),
                minY: 0,
                maxY: 100,
              ),
            ),
          ),
          // Pie Chart on top
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.red,
                      value: 30,
                      title: 'A',
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: 40,
                      title: 'B',
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Pie Chart at the bottom
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.red,
                      value: 25,
                      title: 'X',
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: 35,
                      title: 'Y',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
