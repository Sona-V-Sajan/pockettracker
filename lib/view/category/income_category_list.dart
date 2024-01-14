import 'package:flutter/material.dart';
import 'package:pockettracker/controller/db/category/category_db.dart';
import 'package:pockettracker/model/category/category_model.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListener,
        builder: (BuildContext, List<CategoryModel> newlist, Widget? _){
          return ListView.separated(
              padding: EdgeInsets.all(20),
              itemBuilder: (context,index){
                final category=newlist[index];
                return Card(
                  color: Colors.grey[100],
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(onPressed: (){
                      CategoryDB.instance.deleteCategory(category.id);
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                  ),
                );
              }, separatorBuilder:
              (context,index){
            return SizedBox(height: 10,);
          }, itemCount: newlist.length);
        });
  }
}
