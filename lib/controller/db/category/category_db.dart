
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pockettracker/model/category/category_model.dart';

const CATEGORY_DB_NAME ="category-database";

abstract class CategoryDbFunctions{
 Future <List<CategoryModel>>getCategories();
  Future <void> insertCategory(CategoryModel value);
  Future<void>deleteCategory(String categoryId);
}
class CategoryDB implements CategoryDbFunctions {
  // using singleton
  CategoryDB._obj();
  static CategoryDB instance = CategoryDB._obj();
  factory CategoryDB(){
    return instance;
  }



  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =ValueNotifier([]);


  @override
 Future<void>insertCategory(CategoryModel value) async{
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(value.id,value);
    refershUI();
   }

  @override
  Future<List<CategoryModel>> getCategories()async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }
  Future <void> refershUI() async{
    final allCategories = await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    await Future.forEach(
        allCategories, (CategoryModel category ){
      if(category.type == CategoryType.income){
        
        incomeCategoryListListener.value.add(category);
      }
      else{
        expenseCategoryListListener.value.add(category);
      }

    });
    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
    
  }

  @override
  Future<void> deleteCategory(String categoryId) async{
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.delete(categoryId);
    refershUI();

  }

  }



