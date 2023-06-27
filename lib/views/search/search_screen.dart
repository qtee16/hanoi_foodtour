import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/models/food.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';
import 'package:hanoi_foodtour/view_models/search_view_model.dart';
import 'package:hanoi_foodtour/widgets/food_card_item.dart';
import 'package:hanoi_foodtour/widgets/restaurant_card_item.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? content;
  List<Restaurant> restaurants = [];
  List<Food> foods = [];

  List searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          cursorColor: AppColors.mainColor,
          decoration: const InputDecoration(
            hintText: "Tìm kiếm món ăn hoặc quán",
            hintStyle: TextStyle(fontSize: 16, color: AppColors.greyText),
            focusedBorder: InputBorder.none,
          ),
          onFieldSubmitted: (value) async {
            if (value.isNotEmpty) {
              await context.read<SearchViewModel>().searchFoodAndRestaurant(value);
              setState(() {
                searchResult = List.from(context.read<SearchViewModel>().searchResult);
              });
            }
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
              color: AppColors.greyBorder,
              height: 1.0,
          ),
        )
      ),
      body: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: searchResult.length,
          itemBuilder: (context, index) {
            final item = searchResult[index];
            return Column(
              children: [
                item is Food
                  ? FoodCardItem(food: item)
                  : RestaurantCardItem(restaurant: item),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.greyColor,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}