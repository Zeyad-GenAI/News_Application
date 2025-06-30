import 'package:flutter/material.dart';

import '../Model/category_model.dart';
import 'category_card.dart';

class CategoryListView extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoryListView({
    Key? key,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int selectedIndex = 0;

  final List<CategoryModel> categoryList = const [
    CategoryModel(
      categoryImage: 'assets/images/sport.png',
      categoryName: 'Sports',
    ),
    CategoryModel(
      categoryImage: 'assets/images/tech.png',
      categoryName: 'Technology',
    ),
    CategoryModel(
      categoryImage: 'assets/images/health.png',
      categoryName: 'Health',
    ),
    CategoryModel(
      categoryImage: 'assets/images/science.png',
      categoryName: 'Science',
    ),
    CategoryModel(
      categoryImage: 'assets/images/business.png',
      categoryName: 'Business',
    ),
    CategoryModel(
      categoryImage: 'assets/images/entertainment.png',
      categoryName: 'Entertainment',
    ),
  ];

  // Map category names to API parameter values
  String getCategoryParam(String categoryName) {
    final Map<String, String> categoryMap = {
      'Sports': 'sports',
      'Technology': 'technology',
      'Health': 'health',
      'Science': 'science',
      'Business': 'business',
      'Entertainment': 'entertainment',
    };

    return categoryMap[categoryName] ?? 'general';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onCategorySelected(
                  getCategoryParam(categoryList[index].categoryName)
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  CategoryCard(
                    categoryModel: categoryList[index],
                    isSelected: selectedIndex == index,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 4,
                    width: 30,
                    decoration: BoxDecoration(
                      color: selectedIndex == index ? Colors.amber : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}