import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../data/models/promotion_model.dart';

class BannerCarousel extends StatelessWidget {
  final List<Promotion> promotions;

  BannerCarousel({required this.promotions});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: promotions.map((promotion) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(promotion.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}
