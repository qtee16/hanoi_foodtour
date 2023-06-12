import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/widgets/cached_image_widget.dart';
import 'package:hanoi_foodtour/widgets/comment_widget.dart';
import 'package:hanoi_foodtour/widgets/content_container.dart';
import 'package:hanoi_foodtour/widgets/custom_rating_widget.dart';
import 'package:hanoi_foodtour/widgets/list_card_item.dart';

import '../../routes/navigation_services.dart';

class RestaurantDetail extends StatefulWidget {
  const RestaurantDetail({super.key});

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        // backgroundColor: AppColors.backgroundColor,
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
                        child: Image.network(
                          "https://owa.bestprice.vn/images/articles/uploads/an-sach-15-quan-pho-ngon-re-o-ha-noi-5f6c02a1e0b66.jpg",
                          height: 240,
                          fit: BoxFit.cover,
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
                      const Positioned(
                        top: 124,
                        left: 20,
                        child: CachedImageWidget(
                          imageURL:
                              "https://cdn.tgdd.vn/Files/2020/12/31/1317213/top-10-quan-pho-ngon-tru-danh-khap-sai-gon-ma-ban-nen-an-thu-mot-lan-202206031127464521.jpeg",
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
                          const Text(
                            "Phở Bát Đàn",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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
                              Container(
                                width: 300,
                                child: const Text(
                                  "Ngõ 50 Tạ Quang Bửu, Hai Bà Trưng",
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
                              Container(
                                width: 300,
                                child: const Text(
                                  "4.3 (100 đánh giá)",
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
                              Container(
                                width: 300,
                                child: const Text(
                                  "50",
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
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 4, right: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.orange),
                                child: Text(
                                  "Phở",
                                  style: const TextStyle(
                                      color: AppColors.whiteColor),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 4, right: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.orange),
                                child: Text(
                                  "Phở",
                                  style: const TextStyle(
                                      color: AppColors.whiteColor),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 4, right: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.orange),
                                child: Text(
                                  "Phở",
                                  style: const TextStyle(
                                      color: AppColors.whiteColor),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 4, right: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.orange),
                                child: Text(
                                  "Phở",
                                  style: const TextStyle(
                                      color: AppColors.whiteColor),
                                ),
                              ),
                            ],
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
                          const Text(
                              "Nước dùng ngọt, đậm vị. Sợi phở dai, ngon. Thịt bò được nấu vừa tái chín, không quá dai. Có 3 option 30.000 - 35.000 - 40.000.")
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const ListCardItem(
                  title: "Menu của quán",
                  subTitle: "Khám phá các món ăn đa dạng",
                ),
                const SizedBox(
                  height: 8,
                ),
                const ContentContainer(
                  title: "Đánh giá",
                  contentWidget: CustomRatingWidget(),
                ),
                const SizedBox(
                  height: 8,
                ),
                const ContentContainer(
                  title: "Bình luận",
                  contentWidget: CommentWidget(),
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
                    Text(
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
                    Text(
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
        ));
  }
}
