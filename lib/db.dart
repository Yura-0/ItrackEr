import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'core/blocs/transactions_bloc/transactions_cubit.dart';

part 'db.g.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().nullable()();
  IntColumn get categoryId => integer()();
  BoolColumn get isIncome => boolean()();
}

@DriftDatabase(tables: [Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<TransactionModel>> getAllTransactions() async {
    final database = AppDatabase();

    final transactions = await database.select(database.transactions).get();

    final transactionModels = transactions.map((transaction) {
      return TransactionModel.fromDatabase(
        transaction.id,
        transaction.name,
        transaction.amount,
        transaction.date,
        transaction.description ?? '',
        transaction.categoryId,
        transaction.isIncome,
      );
    }).toList();

    return transactionModels;
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    return into(transactions).insert(TransactionsCompanion(
      name: Value(transaction.name),
      amount: Value(transaction.amount),
      date: Value(transaction.date),
      description: Value(transaction.description),
      categoryId: Value(transaction.categoryId),
      isIncome: Value(transaction.isIncome),
    ));
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await (update(transactions)..where((t) => t.id.equals(transaction.id)))
        .write(TransactionsCompanion(
      name: Value(transaction.name),
      amount: Value(transaction.amount),
      date: Value(transaction.date),
      description: Value(transaction.description),
      categoryId: Value(transaction.categoryId),
      isIncome: Value(transaction.isIncome),
    ));
  }

  Future<void> deleteTransaction(int id) async {
    await (delete(transactions)..where((t) => t.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
