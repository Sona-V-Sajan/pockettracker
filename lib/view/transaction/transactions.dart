import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pockettracker/controller/db/category/category_db.dart';
import 'package:pockettracker/controller/db/transaction/transation_db.dart';
import 'package:pockettracker/model/category/category_model.dart';
import 'package:pockettracker/model/transaction/transaction_model.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refersh();
    CategoryDB.instance.refershUI();
    return  ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifer,
        builder: (BuildContext context, List<TransactionModel>newList, Widget?_){
          return ListView.separated(
              padding: EdgeInsets.all(10),
              //values
              itemBuilder: (context,index){
                final _value =newList[index];
                return Slidable(
                  key: Key(_value.id!),
                  startActionPane: ActionPane(motion: ScrollMotion(
                  ), children: [
                    SlidableAction(onPressed: (context ){
                      TransactionDB.instance.deleteTransaction(_value.id!);
                    },icon:Icons.delete,
                      label: 'Delete',
                    )
                  ]),
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 60,
                          child: Text(parseDate(_value.date,),style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,),
                        backgroundColor: _value.type == CategoryType.income ?Colors.green:Colors.red
                        ,
                      ),

                      title: Text("Rs ${_value.amount}"),
                      subtitle: Text(_value.category.name),
                    ),
                  ),
                );
              },
              separatorBuilder: (context,index){
                return SizedBox(
                  height: 10,
                );
              }, itemCount: newList.length);

        });
  }
  String parseDate(DateTime date){
    // final _date =DateFormat.MMMd().format(date);
    // final _splitedDate=_date.split('');
    // return '${_splitedDate.last}\n${_splitedDate.first}';
    // return '${date.day} \n ${date.month}';
    return DateFormat.MMMd().format(date);
  }
}
