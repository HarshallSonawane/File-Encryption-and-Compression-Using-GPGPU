import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:os_gpu_detection/lib.dart';

double timeTakenCPU = 641.3;
double timeTakenGPU = 62.30;

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: true),
        alignment: BarChartAlignment.spaceAround,
        maxY: 1000,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              "${rod.toY} Seconds",
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontFamily: "Cascadia Code",
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;

    switch (value.toInt()) {
      case 0:
        text = cpuName;
        break;
      case 1:
        text = gpuInfo;
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 14,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: timeTakenCPU,
              color: Colors.deepOrange,
              width: 17,
            )
          ],
          showingTooltipIndicators: [1],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: timeTakenGPU, color: Colors.green, width: 17)
          ],
          showingTooltipIndicators: [2],
        ),
      ];
}

class _BarChartContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 700,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(17.0),
        child: _BarChart(),
      ),
    );
  }
}

class BarChartt extends StatefulWidget {
  const BarChartt();

  @override
  State<StatefulWidget> createState() => PlotCharts();
}

class PlotCharts extends State<BarChartt> {
  int touchedIndex = -1;

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.deepOrange,
            value: timeTakenCPU,
            title: '$timeTakenCPU Seconds',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: timeTakenGPU,
            title: '$timeTakenGPU Seconds',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 10),
              Container(
                width: 1000,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _BarChartContainer(),
                ),
              ),
              SizedBox(width: 40),
              Container(
                width: 450,
                height: 585,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 80,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
              height:
          20), 
          Container(
            width: 650,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes the position of the shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Operating System: $platformInfo",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cascadia Code",
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "CPU: $cpuName",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cascadia Code",
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Cores : $cpuCores                  Threads: $cpuThreads",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cascadia Code",
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "RAM : $totalMemory GB",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cascadia Code",
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "GPU : $gpuInfo",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cascadia Code",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
