import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/blocs/transactions_bloc/transactions_cubit.dart';

class MyPieChart extends StatelessWidget {
  final List<TransactionModel> transactions;

  const MyPieChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    List<PieData> data = _prepareChartData();

    return SfCircularChart(
      series: <CircularSeries>[
        PieSeries<PieData, String>(
          dataSource: data,
          xValueMapper: (PieData sales, _) => sales.category,
          yValueMapper: (PieData sales, _) => sales.amount,
          dataLabelMapper: (PieData sales, _) =>
              '${sales.category} : ${sales.percent}%',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }

  List<PieData> _prepareChartData() {
    List<PieData> chartData = [];

    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.yellow,
      Colors.purple,
      Colors.teal,
    ];

    double totalAmount =
        transactions.fold(0, (sum, transaction) => sum + transaction.amount);
    for (var i = 0; i < transactions.length; i++) {
      TransactionModel transaction = transactions[i];
      chartData.add(PieData(
        category: transaction.name,
        amount: transaction.amount,
        percent: (transaction.amount / totalAmount * 100).toStringAsFixed(2),
        color: colors[i % colors.length],
      ));
    }

    return chartData;
  }
}

class PieData {
  final String category;
  final double amount;
  final String percent;
  final Color color;

  PieData(
      {required this.category,
      required this.amount,
      required this.percent,
      required this.color});
}
