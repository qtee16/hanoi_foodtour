import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/widgets/cached_image_widget.dart';

import '../../routes/navigation_services.dart';

class RestaurantDetail extends StatefulWidget {
  const RestaurantDetail({super.key});

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.network(
                "https://owa.bestprice.vn/images/articles/uploads/an-sach-15-quan-pho-ngon-re-o-ha-noi-5f6c02a1e0b66.jpg",
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              top: 120,
              left: 16,
              child: CachedImageWidget(
                imageURL:
                    "https://cdn.tgdd.vn/Files/2020/12/31/1317213/top-10-quan-pho-ngon-tru-danh-khap-sai-gon-ma-ban-nen-an-thu-mot-lan-202206031127464521.jpeg",
                width: 160,
                height: 160,
                border: 80,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: InkWell(
                onTap: () {
                  NavigationService().pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
