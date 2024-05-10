// Модуль контролю стану транзакцій
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../db.dart';

// Модель транзакції
class TransactionModel {
  final int id;
  final String name;
  final double amount;
  final DateTime date;
  final String description;
  final int categoryId;
  final bool isIncome;

  TransactionModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.description,
    required this.categoryId,
    required this.isIncome,
  });

  factory TransactionModel.fromDatabase(
    int id,
    String name,
    double amount,
    DateTime date,
    String description,
    int categoryId,
    bool isIncome,
  ) {
    return TransactionModel(
      id: id,
      name: name,
      amount: amount,
      date: date,
      description: description,
      categoryId: categoryId,
      isIncome: isIncome,
    );
  }

  TransactionModel copyWith({
    int? id,
    String? name,
    double? amount,
    DateTime? date,
    String? description,
    int? categoryId,
    bool? isIncome,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      isIncome: isIncome ?? this.isIncome,
    );
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, name: $name, amount: $amount, date: $date, description: $description, categoryId: $categoryId, isIncome: $isIncome)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.amount == amount &&
        other.date == date &&
        other.description == description &&
        other.categoryId == categoryId &&
        other.isIncome == isIncome;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        description.hashCode ^
        categoryId.hashCode ^
        isIncome.hashCode;
  }
}


// Клас контролю стану транзакцій
class TransactionCubit extends Cubit<List<TransactionModel>> {
  final AppDatabase database;
  TransactionCubit(this.database) : super([]);

  // Метод ініціалізації
  Future<void> initState() async {
    final transactions = await database.getAllTransactions();
    emit(transactions);
  }

 // Метод додавання нової транзакції
 Future<void> addTransaction(TransactionModel transaction) async {
  final newId = await database.insertTransaction(transaction);
  final newTransaction = TransactionModel(
    id: newId,
    name: transaction.name,
    amount: transaction.amount,
    date: transaction.date,
    description: transaction.description,
    categoryId: transaction.categoryId,
    isIncome: transaction.isIncome,
  );
  final updatedTransactions = [...state, newTransaction];
  emit(updatedTransactions);
}

  // Метод оновлення транзакції
  Future<void> updateTransaction(TransactionModel transaction) async {
    await database.updateTransaction(transaction);
    final updatedTransactions = [
      for (final t in state)
        if (t.id == transaction.id) transaction else t
    ];
    emit(updatedTransactions);
  }

  // Метод видалення транзакції
  Future<void> deleteTransaction(TransactionModel transaction) async {
    await database.deleteTransaction(transaction.id);
    final updatedTransactions =
        state.where((t) => t.id != transaction.id).toList();
    emit(updatedTransactions);
  }
}
