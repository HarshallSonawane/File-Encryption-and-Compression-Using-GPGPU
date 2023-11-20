
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

double timeTakenCPU = 400.51;
double timeTakenGPU = 20.32;

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
        maxY: 500,
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
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      fontFamily: "Cascadia Code",
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    
    switch (value.toInt()) {
      case 0:
        text = 'CPU';
        break;
      case 1:
        text = 'GPU';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1,
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
          sideTitles: SideTitles(showTitles: true),
         
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
            BarChartRodData(
              toY: timeTakenGPU,
              color: Colors.green,
              width: 17
            )
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
      child: _BarChart(),
      
    );
  }
}

class BarChartt extends StatefulWidget {


  const BarChartt({super.key});

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
            title: '$timeTakenCPU ms',
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
            title: '$timeTakenGPU ms',
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
      body: 
         Row(
          children: <Widget>[
            SizedBox(width: 10),
            Container(
              width: 1000,
              height: 700,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _BarChartContainer(),
              ),
            ),
            SizedBox(width: 40), 
             Container(
              
              width: 450,
              height: 665, 
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
    ); 
  }
}

