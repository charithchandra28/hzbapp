import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final List<Product> products;

  ProductCard({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                child: Image.network(
                  product.imageUrl,
                  height: 120.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14.sp, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
