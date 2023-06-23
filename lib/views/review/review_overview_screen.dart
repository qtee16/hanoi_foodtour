import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/view_models/restaurant_view_model.dart';
import 'package:hanoi_foodtour/widgets/cached_image_widget.dart';
import 'package:hanoi_foodtour/widgets/custom_animated_fab.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class ReviewOverviewScreen extends StatefulWidget {
  const ReviewOverviewScreen({super.key});

  @override
  State<ReviewOverviewScreen> createState() => _ReviewOverviewScreenState();
}

class _ReviewOverviewScreenState extends State<ReviewOverviewScreen> {
  final scrollController = ScrollController();
  bool _showFab = true;

  _buildChildWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
          color: AppColors.whiteColor,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.greyBackground,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.greyText,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Tìm kiếm món ăn hoặc quán",
                  style: TextStyle(color: AppColors.greyText),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: Container(
            color: AppColors.whiteColor,
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                setState(() {
                  if (direction == ScrollDirection.reverse) {
                    _showFab = false;
                  } else if (direction == ScrollDirection.forward) {
                    _showFab = true;
                  }
                });
                return true;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Consumer<RestaurantViewModel>(
                  builder: (context, model, child) {
                    List<Restaurant> reviewedRestaurants =
                        model.reviewedRestaurants;
                    return Column(
                        children: reviewedRestaurants.map((e) {
                      return Column(
                        children: [
                          RestaurantCardItem(
                            restaurant: e,
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.greyColor,
                          ),
                        ],
                      );
                    }).toList());
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildNotAuthWidget() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          NavigationService().pushNamed(ROUTE_SIGN_IN);
        },
        child: const Text("Đăng nhập để review"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final isLogin = authViewModel.isLogin;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Danh sách quán đã review",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: isLogin ? _buildChildWidget() : _buildNotAuthWidget(),
      floatingActionButton: isLogin
          ? CustomAnimatedFAB(
              showFab: _showFab,
              onTap: () {
                NavigationService().pushNamed(ROUTE_REVIEW_RESTAURANT);
              },
            )
          : null,
    );
  }
}

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
                                : "4.3 (100 đánh giá)",
                            style: TextStyle(fontSize: 12),
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
                            style: TextStyle(fontSize: 12),
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
                          style: TextStyle(fontSize: 12),
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
