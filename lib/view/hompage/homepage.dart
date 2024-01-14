import 'package:flutter/material.dart';
import 'package:pockettracker/view/add_transaction/add_transaction.dart';
import 'package:pockettracker/view/category/category.dart';
import 'package:pockettracker/view/category/category_add_popup.dart';
import 'package:pockettracker/view/hompage/widgets/bottom_navigation.dart';
import 'package:pockettracker/view/transaction/transactions.dart';

class Home extends StatelessWidget {
   Home({super.key});
  static  ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _page = [
    TransactionsPage(),
    CategoryPage()];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("POCKET  TRACKER",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
      ),
      bottomNavigationBar: PocketTrackerBottomNavigation(),
      body: SafeArea(child: ValueListenableBuilder(valueListenable: selectedIndexNotifier, builder: (BuildContext context,int UpdatedIndex, _){
        return _page[UpdatedIndex];
      })),
      floatingActionButton:
      FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        onPressed: (){
          if(selectedIndexNotifier.value== 0){
            print("Add transactions");
            Navigator.of(context).pushNamed(Add_transaction.routeName);
          }
          else{
            print("Add category");
            showCategoryPopup(context);
            // final  sample =CategoryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //    name: "Travel",
            //   type: CategoryType.income,
            // );
            // CategoryDB().insertCategory(sample);
          }

      },
        child: Icon(Icons.add,color:Colors.white,),

      ) ,
    );
  }
}
