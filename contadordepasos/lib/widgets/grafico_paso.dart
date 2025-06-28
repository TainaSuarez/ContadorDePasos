import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficoPasos extends StatelessWidget {
  final List<int> datosPorHora;

  const GraficoPasos({required this.datosPorHora, super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(24, (i) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: datosPorHora[i].toDouble(),
                color: Colors.teal,
              )
            ],
          );
        }),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 3,
              getTitlesWidget: (value, _) =>
                  Text("${value.toInt()}h", style: TextStyle(fontSize: 10)),
            ),
          ),
        ),
      ),
    );
  }
}
