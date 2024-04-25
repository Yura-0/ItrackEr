import 'package:flutter/material.dart';
import 'package:itracker/l10n/app_loc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/blocs/transactions_bloc/transactions_cubit.dart';

class MyPieChart extends StatelessWidget {
  final List<TransactionModel> transactions;

  const MyPieChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    List<PieData> data = _prepareChartData(context);

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

  List<PieData> _prepareChartData(BuildContext context) {
    Map<int, double> categoryAmountMap = {};

    for (var transaction in transactions) {
      if (categoryAmountMap.containsKey(transaction.categoryId)) {
        categoryAmountMap[transaction.categoryId] =
            (categoryAmountMap[transaction.categoryId] ?? 0) +
                transaction.amount;
      } else {
        categoryAmountMap[transaction.categoryId] = transaction.amount;
      }
    }

    double totalAmount =
        categoryAmountMap.values.fold(0, (sum, amount) => sum + amount);

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

    categoryAmountMap.forEach((categoryId, amount) {
      String categoryName = getCategoryName(categoryId, context);
      double percent = (amount / totalAmount * 100).toDouble();
      chartData.add(PieData(
        category: categoryName,
        amount: amount,
        percent: percent.toStringAsFixed(2),
        color: colors[(categoryId - 1) % colors.length],
      ));
    });

    return chartData;
  }

  String getCategoryName(int categoryId, BuildContext context) {
    switch (categoryId) {
      case 1:
        return context.loc.bank_storage;
      case 2:
        return context.loc.cash_storage;
      case 3:
        return context.loc.passive_income;
      case 4:
        return context.loc.payments;
      case 5:
        return context.loc.shopping;
      case 6:
        return context.loc.medicine;
      case 7:
        return context.loc.entertainment;
      case 8:
        return context.loc.jorney;
      case 9:
        return context.loc.auto;
      default:
        return 'Unknown';
    }
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
