import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficoWidget extends StatelessWidget {
  final double entradas;
  final double gastos;

  const GraficoWidget({
    super.key,
    required this.entradas,
    required this.gastos,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: entradas,
              title: "Entradas",
            ),
            PieChartSectionData(
              value: gastos,
              title: "Gastos",
            ),
          ],
        ),
      ),
    );
  }
}
