import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../widgets/cached_image_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<AuthViewModel>().currentUser;
    bool isLogin = currentUser != null;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                            NavigationService().pushNamed(ROUTER_PROFILE);
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
                    Container(
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
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const ListCardItem(
                title: "Những món phở thịnh hành",
                subTitle: "Nơi lưu giữ hương vị truyền thống",
              ),
              const SizedBox(height: 8),
              const ListCardItem(
                title: "Những quán phở thịnh hành",
                subTitle: "Nơi lưu giữ hương vị truyền thống",
                isFoodList: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                          NavigationService().pushNamed(ROUTER_FOOD_DETAIL);
                        } else {
                          NavigationService()
                              .pushNamed(ROUTER_RESTAURANT_DETAIL);
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
