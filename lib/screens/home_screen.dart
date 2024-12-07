import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../blocs/guest/guest_bloc.dart';
import '../blocs/guest/guest_state.dart';
import '../widgets/category_card.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.jpg', // Replace with your app logo path
          height: 40.h,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30.sp),
            onPressed: () {
              // Navigate to login/signup screen
            },
          ),
        ],
      ),
      body: BlocBuilder<GuestBloc, GuestState>(
        builder: (context, state) {
          if (state is GuestLoading) {
            return Center(child: CircularProgressIndicator());
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
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CategoryCard(categories: state.categories),

                    SizedBox(height: 20.h),

                    // Popular Items/Vendors
                    Text(
                      "Popular Items",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ProductCard(products: state.products),
                  ],
                ),
              ),
            );
          } else if (state is GuestError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
