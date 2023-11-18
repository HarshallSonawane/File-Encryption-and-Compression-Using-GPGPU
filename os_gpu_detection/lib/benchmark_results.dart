// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class BenchMark_Results extends StatelessWidget {
  final String selectedFileName;
  final String fileExt;
  final String filePath;
  final String submittedKey;

  BenchMark_Results({
    required this.selectedFileName,
    required this.fileExt,
    required this.filePath,
    required this.submittedKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Selected File Name: $selectedFileName'),
            Text('File Extension: $fileExt'),
            Text('File Path: $filePath'),
            Text('Submitted Key: $submittedKey'),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class BenchMark_Results extends StatelessWidget {
//   final String selectedFileName;
//   final String fileExt;
//   final String filePath;
//   final String submittedKey;

//   BenchMark_Results({
//     required this.selectedFileName,
//     required this.fileExt,
//     required this.filePath,
//     required this.submittedKey,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Charts Example'),
//       ),
//       body: Column(
//         children: [
//           // Bar Chart on the left
//           Container(
//             width: 300,
//             height: 500,
//             child: BarChart(
//               BarChartData(
//                 barGroups: [
//                   BarChartGroupData(x: 0, barRods: [
//                     BarChartRodData(fromY: 0, color: Colors.blue, toY: 20),
//                   ]),
//                   BarChartGroupData(x: 1, barRods: [
//                     BarChartRodData(fromY: 0, color: Colors.blue, toY: 20),
//                   ]),
//                   BarChartGroupData(x: 2, barRods: [
//                     BarChartRodData(fromY: 0, color: Colors.blue, toY: 20),
//                   ]),
//                   BarChartGroupData(x: 2, barRods: [
//                     BarChartRodData(fromY: 0, color: Colors.blue, toY: 20),
//                   ]),
//                 ],
//                 borderData: FlBorderData(show: true),
//                 minY: 0,
//                 maxY: 100,
//               ),
//             ),
//           ),
//           // Pie Charts stacked vertically
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: PieChart(
//                     PieChartData(
//                       sections: [
//                         PieChartSectionData(
//                           color: Colors.red,
//                           value: 30,
//                           title: 'A',
//                         ),
//                         PieChartSectionData(
//                           color: Colors.green,
//                           value: 40,
//                           title: 'B',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: PieChart(
//                     PieChartData(
//                       sections: [
//                         PieChartSectionData(
//                           color: Colors.red,
//                           value: 25,
//                           title: 'X',
//                         ),
//                         PieChartSectionData(
//                           color: Colors.green,
//                           value: 35,
//                           title: 'Y',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
