import 'package:flutter/material.dart';

import '../constants.dart';
import '../routes/navigation_services.dart';
import '../routes/routes.dart';
import 'cached_image_widget.dart';

class ListCardItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isFoodList;
  const ListCardItem({
    super.key,
    required this.title,
    required this.subTitle,
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
              itemCount: 6,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    SizedBox(
                      width: index == 0 ? 16 : 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isFoodList) {
                          NavigationService().pushNamed(ROUTE_FOOD_DETAIL);
                        } else {
                          NavigationService()
                              .pushNamed(ROUTE_RESTAURANT_DETAIL);
                        }
                      },
                      child: Container(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CachedImageWidget(
                              imageURL:
                                  "https://cdn.pastaxi-manager.onepas.vn/content/uploads/articles/01-Phuong-Mon%20ngon&congthuc/1.%20pho%20ha%20noi/canh-nau-pho-ha-noi-xua-mang-huong-vi-kinh-do-cua-80-nam-ve-truoc-1.jpg",
                              width: 160,
                              height: 160,
                              border: 8,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "Phở bò tái chín",
                              style: TextStyle(
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
                                      const Text(
                                        "35.000VND",
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
                                const Text(
                                  "4.3 (100 đánh giá)",
                                  style: TextStyle(
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
                                      const Text(
                                        "50 Tạ Quang Bửu",
                                        style: TextStyle(
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
                      width: index == 5 ? 16 : 0,
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
