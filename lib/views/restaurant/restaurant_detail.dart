import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/utils/utils.dart';
import 'package:hanoi_foodtour/view_models/restaurant_view_model.dart';
import 'package:hanoi_foodtour/widgets/cached_image_widget.dart';
import 'package:hanoi_foodtour/widgets/comment_widget.dart';
import 'package:hanoi_foodtour/widgets/content_container.dart';
import 'package:hanoi_foodtour/widgets/custom_rating_widget.dart';
import 'package:hanoi_foodtour/widgets/list_card_item.dart';
import 'package:provider/provider.dart';

import '../../models/food.dart';
import '../../models/rating.dart';
import '../../models/restaurant.dart';
import '../../routes/navigation_services.dart';
import '../../view_models/auth_view_model.dart';
import '../../widgets/app_toaster.dart';
import '../../widgets/custom_loading.dart';

class RestaurantDetail extends StatefulWidget {
  const RestaurantDetail({
    super.key,
    required this.restaurant,
  });
  final Restaurant restaurant;

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  double? myRating;
  String? userId;
  String? token;
  bool isLogin = false;

  late double rating;
  late int countRatings;
  List<Rating> ratings = [];
  List<int> categories = [];
  List<Food> foods = [];

  @override
  void initState() {
    super.initState();
    rating = widget.restaurant.rating;
    countRatings = widget.restaurant.countRatings;
    updateFood();
    updateRating();

    final authViewModel = context.read<AuthViewModel>();
    userId = authViewModel.currentUser?.id;
    token = authViewModel.token;
    isLogin = authViewModel.isLogin;

    if (widget.restaurant.rating > 0) {
      final data = {
        "restaurantId": widget.restaurant.id,
      };
      context
          .read<RestaurantViewModel>()
          .getAllRestaurantRating(data)
          .then((value) {
        setState(() {
          ratings = List.from(value);
        });
      });
    }

    if (userId != null && token != null) {
      final data = {"ratedObjectId": widget.restaurant.id};
      context
          .read<RestaurantViewModel>()
          .getMyRestaurantRating(userId!, data, token!)
          .then(
        (rating) {
          if (rating != null) {
            setState(() {
              myRating = rating.rating;
              print(myRating);
            });
          }
        },
      );
    }
  }

  updateFood() async {
    final foodList = await context
        .read<RestaurantViewModel>()
        .getAllFoodOfRestaurant(widget.restaurant.id);
    print("FOOD LIST");
    print(foodList);
    setState(() {
      foods = List.from(foodList);
    });
    updateCategories();
  }

  updateCategories() {
    final categoriesList = foods.map((e) => e.category).toSet().toList();
    setState(() {
      categories = List.from(categoriesList);
    });
  }

  updateRating() async {
    final data = {
      "restaurantId": widget.restaurant.id,
    };
    final newRating =
        await context.read<RestaurantViewModel>().getAllRestaurantRating(data);
    double sum = 0;
    newRating.forEach((e) {
      sum += e.rating;
    });
    setState(() {
      ratings = List.from(newRating);
      countRatings = ratings.length;
      rating = sum / countRatings;
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: maxWidth,
                height: 280,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: CachedImageWidget(
                        imageURL: widget.restaurant.coverImageUrl,
                        height: 240,
                      ),
                    ),
                    Positioned(
                      top: 240,
                      left: 0,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 16,
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 124,
                      left: 20,
                      child: CachedImageWidget(
                        imageURL: widget.restaurant.avatarUrl,
                        width: 152,
                        height: 152,
                        border: 76,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.whiteColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.restaurant.restaurantName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AssetPaths.iconPath.getLocationIconPath,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            SizedBox(
                              width: 300,
                              child: Text(
                                widget.restaurant.address,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AssetPaths.iconPath.getStarIconPath,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            SizedBox(
                              width: 300,
                              child: Text(
                                widget.restaurant.rating == 0 && ratings.isEmpty
                                    ? "Chưa có đánh giá"
                                    : "$rating ($countRatings đánh giá)",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AssetPaths.iconPath.getHeartIconPath,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            SizedBox(
                              width: 300,
                              child: Text(
                                widget.restaurant.likedUserIdList.length
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Danh mục món ăn",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Wrap(
                          children: categories.map((item) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(bottom: 4, right: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.orange),
                              child: Text(
                                Utils.categoriesMap[item].toString(),
                                style: const TextStyle(
                                    color: AppColors.whiteColor),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () {
                            NavigationService().pushNamed(
                              ROUTE_REVIEW_FOOD,
                              arguments: {
                                "restaurantId": widget.restaurant.id,
                              },
                            );
                          },
                          child: const Text(
                            "Review về món ăn của quán",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.whiteColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Review",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(widget.restaurant.review)
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              // const ListCardItem(
              //   title: "Menu của quán",
              //   subTitle: "Khám phá các món ăn đa dạng",
              // ),
              const SizedBox(
                height: 8,
              ),
              ContentContainer(
                title: "Đánh giá",
                contentWidget: CustomRatingWidget(
                  currentRating: rating,
                  countRating: countRatings,
                  myRating: myRating,
                  ratings: ratings,
                  onRating: (rating) async {
                    if (rating != myRating && rating != 0) {
                      final data = {
                        "userId": userId,
                        "restaurantId": widget.restaurant.id,
                        "rating": rating,
                      };
                      showAppLoading(context);
                      await context
                          .read<RestaurantViewModel>()
                          .ratingRestaurant(data, token!);
                      updateRating();
                      NavigationService().pop();
                      // ignore: use_build_context_synchronously
                      AppToaster.showToast(
                        context: context,
                        msg: "Đánh giá thành công",
                        type: AppToasterType.success,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const ContentContainer(
                title: "Bình luận",
                contentWidget: CommentWidget(),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: AppColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.whiteColor),
                  side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(color: Colors.red))),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset(
                    AssetPaths.iconPath.getHeartIconPath,
                    width: 16,
                    height: 16,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Yêu thích",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.mainColor),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset(
                    AssetPaths.iconPath.getRouteIconPath,
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Tìm đường",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
