import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../widgets/cached_image_widget.dart';
import '../../widgets/list_card_item.dart';

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
