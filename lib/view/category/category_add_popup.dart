
import 'package:flutter/material.dart';
import 'package:pockettracker/controller/db/category/category_db.dart';
import 'package:pockettracker/model/category/category_model.dart';
ValueNotifier<CategoryType> seletedCategoryNotifier =ValueNotifier(CategoryType.income);
Future<void > showCategoryPopup(BuildContext context) async {
  final nameEditingController=TextEditingController();
  showDialog(
      context: context,
      builder: (ctx){
        return SimpleDialog(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.zero
          ),
          title: Text("Add Category"),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameEditingController,
                decoration:InputDecoration(
                  hintText:"Categoryname",
                  border: OutlineInputBorder(
                  )
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(title: "Income", type: CategoryType.income),
                  RadioButton(title: "Expense", type: CategoryType.expense)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style:ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Colors.deepPurple),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(0)))
                ),
                  onPressed: (){
                  final name = nameEditingController.text.trim();
                  final type = seletedCategoryNotifier.value;
                  if(name.isEmpty){
                    return;
                  }
                 final category= CategoryModel(
                      id:DateTime.now().millisecondsSinceEpoch.toString(),
                      name: name,
                      type: type);
                  CategoryDB().insertCategory(category);
                  Navigator.of(ctx).pop();
                  },
                  child: Text("Add",style:TextStyle(color: Colors.white),)),
            )
          ],
        );

  });
}
class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
   RadioButton({
    required this.title,
     required this.type});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
       ValueListenableBuilder(
           valueListenable: seletedCategoryNotifier,
           builder: (BuildContext context, CategoryType newCategory, Widget?_){
             return Radio<CategoryType>(
             value: type,
             groupValue: seletedCategoryNotifier.value,
             onChanged: (value){
               if(value== null){
                 return;
               }
               seletedCategoryNotifier.value=value;
               seletedCategoryNotifier.notifyListeners();
             });
       }),
        Text(title),
      ],
    );
  }
}
