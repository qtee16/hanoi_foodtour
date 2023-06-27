import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/view_models/restaurant_view_model.dart';
import 'package:hanoi_foodtour/widgets/custom_animated_fab.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/restaurant_card_item.dart';

class ReviewOverviewScreen extends StatefulWidget {
  const ReviewOverviewScreen({super.key});

  @override
  State<ReviewOverviewScreen> createState() => _ReviewOverviewScreenState();
}

class _ReviewOverviewScreenState extends State<ReviewOverviewScreen> {
  final scrollController = ScrollController();
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    updateMyRestaurant();
  }

  updateMyRestaurant() async {
    final token = context.read<AuthViewModel>().token;
    await context.read<RestaurantViewModel>().getAllReviewedRestaurant(token);
  }

  _buildChildWidget() {
    return Container(
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
        child: RefreshIndicator(
          onRefresh: () async {
            return await () async {
              await updateMyRestaurant();
            }();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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