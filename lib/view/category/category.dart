import 'package:flutter/material.dart';
import 'package:pockettracker/controller/db/category/category_db.dart';
import 'package:pockettracker/view/category/expense_category_list.dart';
import 'package:pockettracker/view/category/income_category_list.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with SingleTickerProviderStateMixin {
  late TabController tabController ;

  @override
  void initState() {
  tabController =TabController(length: 2, vsync: this);
  CategoryDB().refershUI();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar( controller:tabController,tabs: [
          Tab(text:"INCOME",),
          Tab(text: "EXPENSE",)
        ]),
        Expanded(
          child: TabBarView(
            controller: tabController,
              children: [
                IncomeCategory(),
                ExpenseCategory()
              ]

          ),
        )
      ],
    );
  }
}
