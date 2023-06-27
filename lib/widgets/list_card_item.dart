import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/models/food.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';

import '../constants.dart';
import '../routes/navigation_services.dart';
import '../routes/routes.dart';
import 'cached_image_widget.dart';

class ListCardItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isFoodList;
  final List data;
  const ListCardItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.data,
    this.isFoodList = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      color: AppColors.whiteColor,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subTitle,
                        style: const TextStyle(color: AppColors.greyText),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 260,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = isFoodList
                    ? data[index] as Food
                    : data[index] as Restaurant;
                return Row(
                  children: [
                    SizedBox(
                      width: index == 0 ? 16 : 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isFoodList) {
                          NavigationService().pushNamed(
                            ROUTE_FOOD_DETAIL,
                            arguments: {
                              "food": item,
                            },
                          );
                        } else {
                          NavigationService().pushNamed(
                            ROUTE_RESTAURANT_DETAIL,
                            arguments: {
                              "restaurant": item,
                            },
                          );
                        }
                      },
                      child: Container(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedImageWidget(
                              imageURL: isFoodList
                                  ? (item as Food).imageUrl
                                  : (item as Restaurant).avatarUrl,
                              width: 160,
                              height: 160,
                              border: 8,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              isFoodList
                                  ? (item as Food).foodName
                                  : (item as Restaurant).restaurantName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: isFoodList ? 4 : 0,
                            ),
                            isFoodList
                                ? Row(
                                    children: [
                                      Image.asset(
                                        AssetPaths.iconPath.getCoinIconPath,
                                        width: 16,
                                        height: 16,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${(item as Food).price} VND",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  AssetPaths.iconPath.getStarIconPath,
                                  width: 16,
                                  height: 16,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                isFoodList
                                    ? Text(
                                        (item as Food).rating == 0
                                            ? "Chưa có đánh giá"
                                            : "${item.rating} (${item.countRatings})",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.greyText,
                                        ),
                                      )
                                    : Text(
                                        (item as Restaurant).rating == 0
                                            ? "Chưa có đánh giá"
                                            : "${item.rating} (${item.countRatings})",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.greyText,
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: !isFoodList ? 8 : 0,
                            ),
                            !isFoodList
                                ? Row(
                                    children: [
                                      Image.asset(
                                        AssetPaths.iconPath.getLocationIconPath,
                                        width: 16,
                                        height: 16,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        (item as Restaurant).address,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.greyText,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: index == data.length - 1 ? 16 : 0,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
