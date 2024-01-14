import 'package:flutter/material.dart';
import 'package:pockettracker/controller/db/category/category_db.dart';
import 'package:pockettracker/model/category/category_model.dart';

class Add_transaction extends StatefulWidget {
  static const routeName ="add transaction";
  const Add_transaction({super.key});

  @override
  State<Add_transaction> createState() => _Add_transactionState();
}

class _Add_transactionState extends State<Add_transaction> {

  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CategoryModel? selectedCategoryModel;
  String? CategoryId;

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          //  purpose
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Purpose",
                  border: OutlineInputBorder()
                ),
              ),
            ),
            //Amount
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Amount",
                    border: OutlineInputBorder()
                ),
              ),
            ),
            //calender
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton.icon(
                  onPressed: () async{
                 final selectedDateTemp=await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now(),
                 );
                 if(selectedDateTemp == null){
                   return;
                 }
                 else{
                   print(selectedDateTemp.toString());
                   setState(() {
                     selectedDate = selectedDateTemp;
                   });

                 }
              },
                icon: Icon
                (Icons.calendar_today),
                  label: Text(selectedDate == null?"Select Date":selectedDate.toString()),
              ),
            ),

           //Category
           Row(
             children: [
               Row(
                 children: [
                   Radio(
                       value:CategoryType.income,
                       groupValue: selectedCategoryType,
                       onChanged: (newvalue){
                         setState(() {
                           selectedCategoryType = CategoryType.income;
                           CategoryId = null;
                         });
                       }
                   ),
                   Text("Income")
                 ],
               ),
               Row(
                 children: [
                   Radio(
                       value:CategoryType.expense,
                       groupValue: selectedCategoryType,
                       onChanged: (newvalue){
                         setState(() {
                           selectedCategoryType = CategoryType.expense;
                           CategoryId =null;
                         });
                       }
                   ),
                   Text("Expense")
                 ],
               ),
             ],
           ),
           //Category Type
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButton(
                value: CategoryId,
                hint:Text("Select Category"),
                  items:(selectedCategoryType == CategoryType.income
                      ? CategoryDB().incomeCategoryListListener:
                     CategoryDB().expenseCategoryListListener)
                      .value.map((e){
                    return DropdownMenuItem(
                      value: e.id,
                        child: Text(e.name));

                  } ).toList(),
                  onChanged: (seletedValue){
                    print("Selected value");
                   setState(() {
                     CategoryId = seletedValue;
                   });

                  }),
            ),
            //submit
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(

                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),


                ),
                  onPressed: (){},
                  child: Text("Submit",style:TextStyle(color: Colors.white),)),
            )




          ],
        ),
      ),
    );
  }
}
