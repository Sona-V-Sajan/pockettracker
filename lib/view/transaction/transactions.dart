import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      padding: EdgeInsets.all(10),
        itemBuilder: (context,index){
          return Card(
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                radius: 60,
                  child: Text("10 \n Dec",textAlign: TextAlign.center,)),
              title: Text("10000"),
              subtitle: Text("Travel"),
            ),
          );
        },
        separatorBuilder: (context,index){
          return SizedBox(
            height: 10,
          );
        }, itemCount: 10);
  }
}
