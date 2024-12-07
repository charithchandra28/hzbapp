import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final List<Category> categories;

  CategoryCard({required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(// TODO Implement this library.
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundImage: NetworkImage(category.iconUrl),
              ),
              SizedBox(height: 5.h),
              Text(
                category.name,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ],
          );
        },
      ),
    );
  }
}
