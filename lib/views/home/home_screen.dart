import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/view_models/food_view_model.dart';
import 'package:hanoi_foodtour/view_models/restaurant_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/food.dart';
import '../../models/user.dart';
import '../../widgets/cached_image_widget.dart';
import '../../widgets/list_card_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Restaurant> restaurants = [];
  List<Food> foods = [];

  @override
  void initState() {
    super.initState();
    updateRestaurants();
    updateFoods();
  }

  updateRestaurants() async {
    final data = await context.read<RestaurantViewModel>().getTopRatingRestaurants(10);
    if (data.isNotEmpty) {
      setState(() {
        restaurants = List.from(data);
      });
    }
  }

  updateFoods() async {
    final data = await context.read<FoodViewModel>().getTopRatingFoods(10);
    if (data.isNotEmpty) {
      setState(() {
        foods = List.from(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<AuthViewModel>().currentUser;
    bool isLogin = currentUser != null;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            return await () async {
              await updateRestaurants();
              await updateFoods();
            }();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  color: AppColors.whiteColor,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Xin chào ${isLogin ? currentUser.username : 'bạn'}!",
                            style: const TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              NavigationService().pushNamed(ROUTE_PROFILE);
                            },
                            child: isLogin && currentUser.avatarUrl != null
                                ? CachedImageWidget(
                                    imageURL: currentUser.avatarUrl!,
                                    width: 36,
                                    height: 36,
                                    border: 18,
                                  )
                                : Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      image: DecorationImage(
                                        image: AssetImage(AssetPaths
                                            .imagePath.getDefaultUserImagePath),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          NavigationService().pushNamed(ROUTE_SEARCH);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
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
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ListCardItem(
                  title: "Món ăn thịnh hành",
                  subTitle: "Tinh hoa ẩm thực Việt",
                  data: foods,
                  type: "top-rating-food",
                ),
                const SizedBox(height: 8),
                ListCardItem(
                  title: "Quán ăn thịnh hành",
                  subTitle: "Nơi lưu giữ hương vị truyền thống",
                  data: restaurants,
                  type: "top-rating-restaurant",
                  isFoodList: false,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
