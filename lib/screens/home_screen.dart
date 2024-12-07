import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../blocs/guest/guest_bloc.dart';
import '../blocs/guest/guest_state.dart';
import '../widgets/category_card.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/skeleton_loader.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Hello, User!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                // Sign Up / Log In
              },
              tooltip: "Toggle Dark Mode",
            ),
          ],
        ),
      ),
      body: BlocBuilder<GuestBloc, GuestState>(
        builder: (context, state) {
          if (state is GuestLoading) {
            return SkeletonLoader(); // Displays skeleton loader while loading
          } else if (state is GuestLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search for items or vendors",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Promotional Banner
                    BannerCarousel(promotions: state.promotions),
                    SizedBox(height: 20.h),

                    // Categories Section
                    Text(
                      "Categories",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 10.h),
                    CategoryCard(categories: state.categories),

                    // Popular Items Section
                    SizedBox(height: 20.h),
                    Text(
                      "Popular Items",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 8.h),
                    ProductCard(products: state.products),
                  ],
                ),
              ),
            );
          } else if (state is GuestError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 50, color: Colors.red),
                  SizedBox(height: 10),
                  Text("Something went wrong!", style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Cart
        },
        child: Icon(Icons.shopping_cart),
        tooltip: "Go to Cart",
      ),
    );
  }
}
