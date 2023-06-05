import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/views/profile/widgets/list_item.dart';
import 'package:hanoi_foodtour/widgets/cached_image_widget.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<AuthViewModel>().currentUser;
    bool isLogin = currentUser != null;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Thông tin cá nhân",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.greyColor,
          ),
          GestureDetector(
            onTap: () {
              isLogin
                  ? NavigationService().pushNamed(ROUTER_PROFILE_DETAIL)
                  : NavigationService().pushNamed(ROUTER_SIGN_IN);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 120,
              color: AppColors.whiteColor,
              child: Row(
                children: [
                  isLogin && currentUser.avatarUrl != null
                      ? CachedImageWidget(
                          imageURL: currentUser.avatarUrl!,
                          width: 80,
                          height: 80,
                          border: 40,
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                              image: AssetImage(
                                  AssetPaths.imagePath.getDefaultUserImagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isLogin ? currentUser.username : "Đăng nhập",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          isLogin
                              ? "Chỉnh sửa thông tin cá nhân"
                              : "Đăng nhập để khám phá thật nhiều món ngon",
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ListItem(
            icon: AssetPaths.iconPath.getRestaurantIconPath,
            title: "Danh sách quán yêu thích",
            callback: () {},
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.greyColor,
          ),
          ListItem(
            icon: AssetPaths.iconPath.getFoodIconPath,
            title: "Danh sách món ăn yêu thích",
            callback: () {},
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.greyColor,
          ),
          ListItem(
            icon: AssetPaths.iconPath.getMapIconPath,
            title: "Danh sách các quán đã đi",
            callback: () {},
          ),
        ],
      ),
    );
  }
}
