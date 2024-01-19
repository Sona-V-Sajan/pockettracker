import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pockettracker/model/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = "transaction-db";

abstract class TransactionDBFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List <TransactionModel>>getTransaction();
  Future<void>deleteTransaction(String transactionId);
}

class TransactionDB implements TransactionDBFunctions {
TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB(){
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionListNotifer =ValueNotifier([]);

//add data using put when id
  @override
  Future<void> addTransaction(TransactionModel obj) async{
   final db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   await db.put(obj.id,obj);
  }

  Future<void> refersh() async{
   final _list = await getTransaction();
   _list.sort ((first,second)=> second.date.compareTo(first.date));
   transactionListNotifer.value.clear();
    transactionListNotifer.value.addAll(_list);
    transactionListNotifer.notifyListeners();

  }
//get data
  @override
  Future<List<TransactionModel>> getTransaction() async{
    final db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String transactionId) async{
    final db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME
    );
    await db.delete(transactionId);
    refersh();

  }
  
}
