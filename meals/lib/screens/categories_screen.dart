import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';
class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('DeliMeal'),
      // ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES.map((catData){
          return CategoryItem(color: catData.color, title: catData.title, id: catData.id,);
        }).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 3/2),
      ),
    );
  }
}
