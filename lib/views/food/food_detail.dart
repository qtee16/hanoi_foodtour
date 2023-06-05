import 'package:flutter/material.dart';

import '../../constants.dart';

class FoodDetail extends StatefulWidget {
  const FoodDetail({super.key});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            centerTitle: false,
            expandedHeight: 300.0,
            flexibleSpace: const FlexibleSpaceBar(
              background: Image(
                image: NetworkImage(
                    "https://cdn.pastaxi-manager.onepas.vn/content/uploads/articles/01-Phuong-Mon%20ngon&congthuc/1.%20pho%20ha%20noi/canh-nau-pho-ha-noi-xua-mang-huong-vi-kinh-do-cua-80-nam-ve-truoc-1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 600,
                  color: Colors.red,
                ),
                Positioned(
                  child: Container(
                    width: 300,
                    height: 200,
                    color: AppColors.whiteColor,
                  ),
                  top: 0,
                  left: 0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
