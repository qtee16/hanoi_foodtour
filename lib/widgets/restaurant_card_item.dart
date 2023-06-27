import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/restaurant.dart';
import '../routes/navigation_services.dart';
import '../routes/routes.dart';
import 'cached_image_widget.dart';

class RestaurantCardItem extends StatelessWidget {
  const RestaurantCardItem({
    super.key,
    required this.restaurant,
  });
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService().pushNamed(
          ROUTE_RESTAURANT_DETAIL,
          arguments: {
            "restaurant": restaurant,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        width: double.infinity,
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedImageWidget(
              width: 80,
              height: 80,
              border: 8,
              imageURL: restaurant.avatarUrl,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.restaurantName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AssetPaths.iconPath.getStarIconPath,
                            width: 14,
                            height: 14,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            restaurant.rating == 0
                                ? "Chưa có đánh giá"
                                : "${restaurant.rating} (${restaurant.countRatings})",
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AssetPaths.iconPath.getHeartIconPath,
                            width: 14,
                            height: 14,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            restaurant.likedUserIdList.length.toString(),
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AssetPaths.iconPath.getLocationIconPath,
                        width: 14,
                        height: 14,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          restaurant.address,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}