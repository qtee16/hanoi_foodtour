import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/models/food.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';
import 'package:hanoi_foodtour/widgets/shimmer_loading.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../routes/navigation_services.dart';
import '../routes/routes.dart';
import 'cached_image_widget.dart';

class ListCardItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isFoodList;
  final String type;
  final List data;
  const ListCardItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.data,
    required this.type,
    this.isFoodList = true,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.decimalPattern();
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      color: AppColors.whiteColor,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              final menuType = ["restaurant-menu", "other-food-of-restaurant"];
              if (menuType.contains(type)) {
                NavigationService().pushNamed(ROUTE_LIST_DETAIL, arguments: { "title": title , "type": type, "isFood": isFoodList, "data": data});
              } else {
                NavigationService().pushNamed(ROUTE_LIST_DETAIL, arguments: { "title": title , "type": type, "isFood": isFoodList,});
              }
            },
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
            height: 300,
            width: double.infinity,
            child: data.isNotEmpty
              ? ListView.builder(
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
                        child: SizedBox(
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
                                maxLines: 2,
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
                                          "${formatter.format((item as Food).price)} VND",
                                          style: const TextStyle(
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
                                        Expanded(
                                          child: Text(
                                            (item as Restaurant).address,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.greyText,
                                            ),
                                            overflow: TextOverflow.ellipsis,
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
              )
              : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: index == 0 ? 16 : 24,
                      ),
                      const SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerLoading(width: 160, height: 160, border: 8),
                            SizedBox(
                              height: 16,
                            ),
                            ShimmerLoading(width: 100, height: 16, border: 4),
                            SizedBox(
                              height: 8,
                            ),
                            ShimmerLoading(width: 50, height: 16, border: 4),
                          ],
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