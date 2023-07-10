import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/view_models/restaurant_view_model.dart';
import 'package:hanoi_foodtour/view_models/user_view_model.dart';
import 'package:hanoi_foodtour/views/profile/widgets/info_text_field.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/user.dart';
import '../../services/select_image.dart';
import '../../widgets/app_toaster.dart';
import '../../widgets/cached_image_widget.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  File? avatarImage;

  @override
  Widget build(BuildContext context) {
    String? token = context.read<AuthViewModel>().token;
    User? currentUser = context.watch<AuthViewModel>().currentUser;
    return Scaffold(
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: AppColors.whiteColor,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  child: Center(
                    child: Stack(
                      children: [
                        currentUser?.avatarUrl != null
                          ? CachedImageWidget(
                              imageURL: currentUser!.avatarUrl!,
                              width: 120,
                              height: 120,
                              border: 60,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: avatarImage == null
                                ? Image.asset(
                                    AssetPaths.imagePath.getDefaultUserImagePath,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    avatarImage!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                            ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: InkWell(
                            onTap: () async {
                              try {
                                File image = await SelectImage.selectImage();
                                setState(() {
                                  avatarImage = image;
                                });
                                if (currentUser != null && avatarImage != null) {
                                  // ignore: use_build_context_synchronously
                                  final newUser = await context.read<UserViewModel>().updateUserAvatar(currentUser.id, avatarImage!, token!);
                                  // ignore: use_build_context_synchronously
                                  context.read<AuthViewModel>().setCurrentUser(newUser);
                                }
                              } on PlatformException catch (e) {
                                if (e.code == 'read_external_storage_denied') {
                                  AppToaster.showToast(
                                    context: context,
                                    msg: "Cần cấp quyền truy cập để tiếp tục",
                                    type: AppToasterType.warning,
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
                InfoTextField(
                  title: "Tên",
                  content: currentUser?.username ?? "",
                  suffixIcon: InkWell(
                    onTap: () {
                      NavigationService().pushNamed(
                        ROUTE_UPDATE_INFO_DETAIL,
                        arguments: {
                          "title": "Thay đổi tên",
                          "type": "name",
                        },
                      );
                    },
                    child: const Icon(Icons.edit, color: AppColors.greyTitle,),
                  ),
                ),
                const SizedBox(height: 16,),
                InfoTextField(
                  title: "Email",
                  content: currentUser?.email ?? "",
                  suffixIcon: InkWell(
                    onTap: () {
                      NavigationService().pushNamed(
                        ROUTE_UPDATE_INFO_DETAIL,
                        arguments: {
                          "title": "Thay đổi email",
                          "type": "email",
                        },
                      );
                    },
                    child: const Icon(Icons.edit, color: AppColors.greyTitle,),
                  ),
                ),
                const SizedBox(height: 16,),
                // InfoTextField(
                //   title: "Số điện thoại",
                //   content: "",
                //   suffixIcon: InkWell(
                //     onTap: () {},
                //     child: const Icon(Icons.edit, color: AppColors.greyTitle,),
                //   ),
                // ),
                // const SizedBox(height: 16,),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Container(
            height: 48,
            color: AppColors.whiteColor,
            padding: const EdgeInsets.only(left: 16, right: 18,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Đổi mật khẩu",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.arrow_forward_ios, color: AppColors.greyTitle, size: 16,),
                )
              ],
            ),
          ),
          const SizedBox(height: 16,),
          InkWell(
            onTap: () async {
              NavigationService().pushNameAndRemoveUntil(ROUTE_HOME);
              await context.read<AuthViewModel>().signOut();
              // ignore: use_build_context_synchronously
              context.read<RestaurantViewModel>().clearData();
            },
            child: Container(
              color: AppColors.whiteColor,
              height: 48,
              child: const Center(
                child: Text(
                  "Đăng xuất",
                  style: TextStyle(
                    color: AppColors.redColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
