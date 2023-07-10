import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/food_card_item.dart';
import '../../widgets/restaurant_card_item.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
    required this.title,
    required this.type,
    this.isFood = true,
  });
  final String title;
  final String type;
  final bool isFood;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      ),
      body: MyListWidget(type: widget.type, isFood: widget.isFood),
    );
  }
}

// ignore: must_be_immutable
class MyListWidget extends StatefulWidget {
  const MyListWidget({
    super.key,
    required this.type,
    required this.isFood,
  });
  final String type;
  final bool isFood;

  @override
  // ignore: library_private_types_in_public_api
  _MyListWidgetState createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, model, child) {
        List dataList = [];
        if (widget.type == "my-liked-restaurant") {
          dataList = model.likedRestaurants;
        } else if (widget.type == "my-liked-food") {
          dataList = model.likeFoods;
        }
        return ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: AppColors.greyBorder,
                ),
                widget.isFood
                  ? FoodCardItem(food: dataList[index])
                  : RestaurantCardItem(restaurant: dataList[index]),
                index == dataList.length - 1
                  ? const Divider(
                    height: 0.5,
                    thickness: 0.5,
                    color: AppColors.greyBorder,
                  )
                  : const SizedBox(),
              ],
            );
          },
        );
      }
    );
  }
}