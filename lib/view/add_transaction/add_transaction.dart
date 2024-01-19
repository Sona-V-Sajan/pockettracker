import 'package:flutter/material.dart';
import 'package:pockettracker/controller/db/category/category_db.dart';
import 'package:pockettracker/controller/db/transaction/transation_db.dart';
import 'package:pockettracker/model/category/category_model.dart';
import 'package:pockettracker/model/transaction/transaction_model.dart';

class Add_transaction extends StatefulWidget {
  static const routeName ="add transaction";
  const Add_transaction({super.key});

  @override
  State<Add_transaction> createState() => _Add_transactionState();
}

class _Add_transactionState extends State<Add_transaction> {

  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? CategoryId;
  final PurposeTextEditingController = TextEditingController();
  final AmountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;

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
                controller:  PurposeTextEditingController,
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
                controller: AmountTextEditingController,
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
                 final _selectedDateTemp=await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now(),
                 );
                 if(_selectedDateTemp == null){
                   return;
                 }
                 else{
                   print(_selectedDateTemp.toString());
                   setState(() {
                     _selectedDate = _selectedDateTemp;
                   });

                 }
              },
                icon: Icon
                (Icons.calendar_today),
                  label: Text(_selectedDate == null?"Select Date":_selectedDate.toString()),
              ),
            ),

           //Category
           Row(
             children: [
               Row(
                 children: [
                   Radio(
                       value:CategoryType.income,
                       groupValue: _selectedCategoryType,
                       onChanged: (newvalue){
                         setState(() {
                           _selectedCategoryType = CategoryType.income;
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
                       groupValue: _selectedCategoryType,
                       onChanged: (newvalue){
                         setState(() {
                           _selectedCategoryType = CategoryType.expense;
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
                  items:(_selectedCategoryType == CategoryType.income
                      ? CategoryDB().incomeCategoryListListener:
                     CategoryDB().expenseCategoryListListener)
                      .value.map((e){
                    return DropdownMenuItem(
                      value: e.id,
                        child: Text(e.name),
                        onTap: (){
                          _selectedCategoryModel = e;
                        }
                    );

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
                  onPressed: (){
                  addTransaction();
                  },
                  child: Text("Submit",style:TextStyle(color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }

 Future  <void> addTransaction() async{
    final _purposeText =PurposeTextEditingController.text;
    final _amountText =AmountTextEditingController.text;
    if(_purposeText.isEmpty){
      return;
    }
    if(_amountText.isEmpty){
      return;
    }
    if(CategoryId == null){
      return;
    }
    if(_selectedDate == null){
      return;
    }
    if(_selectedCategoryModel ==null){
      return;
    }
    final _parseAmount = double.tryParse(_amountText);
    if(_parseAmount == null){
      return;
    }
   final _model= TransactionModel(
        purpose: _purposeText,
        amount: _parseAmount,
        date: _selectedDate!,
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!,
   );
    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refersh();

 }
}

