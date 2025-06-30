import 'package:flutter/material.dart';

import '../Model/category_model.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.categoryModel,
    this.isSelected = false,
  }) : super(key: key);

  final CategoryModel categoryModel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: isSelected
            ? Border.all(color: Colors.amber, width: 2)
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isSelected ? 10 : 12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              categoryModel.categoryImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback gradient if image is not found
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.deepPurple,
                        Colors.blue,
                      ],
                    ),
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
            Center(
              child: Text(
                categoryModel.categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}