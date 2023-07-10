import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/view_models/food_view_model.dart';
import 'package:hanoi_foodtour/view_models/restaurant_view_model.dart';
import 'package:hanoi_foodtour/widgets/custom_animated_fab.dart';
import 'package:hanoi_foodtour/widgets/food_card_item.dart';
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
  String type = "restaurant";

  @override
  void initState() {
    super.initState();
    updateMyRestaurant();
    updateMyFood();
  }

  updateMyRestaurant() async {
    final auth = context.read<AuthViewModel>();
    await context.read<RestaurantViewModel>().getAllReviewedRestaurant(auth.currentUser!.id, auth.token!);
  }

  updateMyFood() async {
    final auth = context.read<AuthViewModel>();
    await context.read<FoodViewModel>().getAllReviewedFood(auth.currentUser!.id, auth.token!);
  }

  _buildChildWidget(model) {
    final List data = type == "restaurant"
      ? model.reviewedRestaurants
      : model.reviewedFoods;
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
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (type != "restaurant") {
                          setState(() {
                            type = "restaurant";
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 4, right: 4,),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: type == "restaurant" ? AppColors.mainColor : AppColors.whiteColor,
                          border: Border.all(color: AppColors.mainColor)
                        ),
                        child: Text(
                          "Quán ăn",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: type == "restaurant" ? AppColors.whiteColor : AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (type != "food") {
                          setState(() {
                            type = "food";
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 4, right: 4,),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: type == "food" ? AppColors.mainColor : AppColors.whiteColor,
                          border: Border.all(color: AppColors.mainColor)
                        ),
                        child: Text(
                          "Món ăn",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: type == "food" ? AppColors.whiteColor : AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: scrollController,
                child: Column(
                  children: data.map((e) {
                    return Column(
                      children: [
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.greyColor,
                        ),
                        type == "restaurant"
                          ? RestaurantCardItem(
                            restaurant: e,
                            isShowBottomOption: true,
                          )
                          : FoodCardItem(food: e,),
                        if (e.id == data.last.id)
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.greyColor,
                          ),
                      ],
                    );
                  }).toList() + [],
                ),
              ),
            ],
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
    final model = type == "restaurant"
      ? context.watch<RestaurantViewModel>()
      : context.watch<FoodViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Review của bạn",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: isLogin ? _buildChildWidget(model) : _buildNotAuthWidget(),
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