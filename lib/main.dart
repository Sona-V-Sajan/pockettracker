import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pockettracker/model/category/category_model.dart';
import 'package:pockettracker/view/add_transaction/add_transaction.dart';
import 'package:pockettracker/view/hompage/homepage.dart';
Future <void> main() async {
  //when app starting plugin are connected or not checking
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
 //checking categoryTypeAdapter
  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  //checking categoryModelAdapter
 if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
   Hive.registerAdapter(CategoryModelAdapter());
 }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Home(),
      routes: {
        Add_transaction.routeName:(context)=>Add_transaction()
      },
    );
  }
}
