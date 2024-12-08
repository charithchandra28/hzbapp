import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/models/promotion_model.dart';

class BannerCarousel extends StatefulWidget {
  final List<Promotion> promotions;
  final Color textColor;
  final Color indicatorActiveColor;
  final Color indicatorInactiveColor;
  final Function(Promotion)? onBannerTap;

  BannerCarousel({
    required this.promotions,
    this.textColor = Colors.white,
    this.indicatorActiveColor = Colors.blue,
    this.indicatorInactiveColor = Colors.grey,
    this.onBannerTap,
  });

  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return widget.promotions.isNotEmpty
        ? Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          itemCount: widget.promotions.length,
          options: CarouselOptions(
            height: isLandscape ? 280.h : 320.h, // Dynamically adjust banner height
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            autoPlayCurve: Curves.easeInOut,
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
          ),
          itemBuilder: (context, index, realIndex) {
            final promotion = widget.promotions[index];
            return _buildBannerItem(promotion);
          },
        ),
        SizedBox(height: 12.h), // Add spacing between banner and dots
        _buildCustomIndicator(),
      ],
    )
        : _buildEmptyPromotions();
  }

  Widget _buildBannerItem(Promotion promotion) {
    return GestureDetector(
      onTap: () {
        if (widget.onBannerTap != null) {
          widget.onBannerTap!(promotion);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Stack(
            children: [
              // Cached Image
              CachedNetworkImage(
                imageUrl: promotion.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) => _buildImagePlaceholder(),
                errorWidget: (context, url, error) => _buildImageErrorWidget(),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              // Text Content
              Positioned(
                bottom: 16.h,
                left: 16.w,
                right: 16.w, // Allow text to fit dynamically within the banner
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promotion.title,
                      style: TextStyle(
                        color: widget.textColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.8),
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      maxLines: 2, // Wrap text to avoid overflow
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (promotion.description != null)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          promotion.description!,
                          style: TextStyle(
                            color: widget.textColor.withOpacity(0.85),
                            fontSize: 14.sp,
                          ),
                          maxLines: 3, // Allow up to 3 lines for descriptions
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.w,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Widget _buildImageErrorWidget() {
    return Container(
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: Icon(Icons.broken_image, size: 40.sp, color: Colors.red),
    );
  }

  Widget _buildCustomIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.promotions.length, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: _currentIndex == index ? 12.h : 8.h,
          width: _currentIndex == index ? 12.w : 8.w,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? widget.indicatorActiveColor
                : widget.indicatorInactiveColor,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildEmptyPromotions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 60.sp, color: Colors.grey),
          SizedBox(height: 10.h),
          Text(
            "No Promotions Available",
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: () {
              // Trigger reload or navigation
            },
            child: Text("Explore Products"),
          ),
        ],
      ),
    );
  }
}
