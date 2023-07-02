import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/services/location_service.dart';
import 'package:hanoi_foodtour/services/select_image.dart';
import 'package:hanoi_foodtour/utils/utils.dart';
import 'package:hanoi_foodtour/view_models/restaurant_view_model.dart';
import 'package:hanoi_foodtour/widgets/cached_image_widget.dart';
import 'package:hanoi_foodtour/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

import '../../view_models/auth_view_model.dart';
import '../../widgets/app_toaster.dart';
import '../../widgets/form_field_widget.dart';

class ReviewRestaurantScreen extends StatefulWidget {
  const ReviewRestaurantScreen({super.key, this.restaurant});
  final Restaurant? restaurant;

  @override
  State<ReviewRestaurantScreen> createState() => _ReviewRestaurantScreenState();
}

class _ReviewRestaurantScreenState extends State<ReviewRestaurantScreen> {
  final restaurantNameController = TextEditingController();
  final addressController = TextEditingController();
  final locationController = TextEditingController();
  final reviewController = TextEditingController();

  File? restaurantAvatar;
  File? restaurantCoverImage;
  Position? location;
  Map<String, dynamic>? updateData;

  @override
  void initState() {
    super.initState();
    if (widget.restaurant != null) {
      restaurantNameController.text = widget.restaurant!.restaurantName;
      addressController.text = widget.restaurant!.address;
      locationController.text = "(${widget.restaurant!.locationLat}, ${widget.restaurant!.locationLong})";
      reviewController.text = widget.restaurant!.review;
      updateData = {
        "userId": widget.restaurant!.userId,
      };
    }
  }

  onCreateOrUpdateRestaurant(String userId, String token) async {
    if (widget.restaurant != null) {
      bool isChanged = false;
      final restaurantName = restaurantNameController.text.trim();
      final address = addressController.text.trim();
      final locationLat = location?.latitude;
      final locationLong = location?.longitude;
      final review = reviewController.text.trim();
      if (restaurantName != widget.restaurant!.restaurantName) {
        updateData!["restaurantName"] = restaurantName;
        isChanged = true;
      }
      if (address != widget.restaurant!.address) {
        updateData!["address"] = address;
        isChanged = true;
      }
      if (locationLat != null && locationLat != widget.restaurant!.locationLat) {
        updateData!["locationLat"] = locationLat;
        isChanged = true;
      }
      if (locationLong != null && locationLong != widget.restaurant!.locationLong) {
        updateData!["locationLong"] = locationLong;
        isChanged = true;
      }
      if (review != widget.restaurant!.review) {
        updateData!["review"] = review;
        isChanged = true;
      }
      if (restaurantAvatar != null) {
        final avatarEncode = await Utils.encodeImage(restaurantAvatar!);
        updateData!["avatarName"] = restaurantAvatar!.path.split('/').last;
        updateData!["avatarData"] = avatarEncode;
        isChanged = true;
      }
      if (restaurantCoverImage != null) {
        final coverImageEncode = await Utils.encodeImage(restaurantCoverImage!);
        updateData!["coverImageName"] = restaurantCoverImage!.path.split('/').last;
        updateData!["coverImageData"] = coverImageEncode;
        isChanged = true;
      }
      if (isChanged) {
        // ignore: use_build_context_synchronously
        showAppLoading(context);
        // ignore: use_build_context_synchronously
        await context
            .read<RestaurantViewModel>()
            .updateRestaurant(
              widget.restaurant!.id,
              updateData!,
              token,
            );
        NavigationService().pop();
        NavigationService().pop();
        // ignore: use_build_context_synchronously
        AppToaster.showToast(
          context: context,
          msg: "Chỉnh sửa quán ăn thành công",
          type: AppToasterType.success,
        );
      }
    } else {
      if (restaurantAvatar != null && restaurantCoverImage != null) {
        final avatarEncode =
            await Utils.encodeImage(restaurantAvatar!);
        final coverImageEncode =
            await Utils.encodeImage(restaurantCoverImage!);
        final restaurantName =
            restaurantNameController.text.trim();
        final address = addressController.text.trim();
        final locationLat = location!.latitude;
        final locationLong = location!.longitude;
        final review = reviewController.text.trim();
        final data = {
          "userId": userId,
          "restaurantName": restaurantName,
          "address": address,
          "locationLat": locationLat,
          "locationLong": locationLong,
          "review": review,
          "avatarName": restaurantAvatar!.path.split('/').last,
          "avatarData": avatarEncode,
          "coverImageName":
              restaurantCoverImage!.path.split('/').last,
          "coverImageData": coverImageEncode,
        };
        // ignore: use_build_context_synchronously
        showAppLoading(context);
        // ignore: use_build_context_synchronously
        await context
            .read<RestaurantViewModel>()
            .createRestaurant(
              data,
              token,
            );
        NavigationService().pop();
        NavigationService().pop();
        // ignore: use_build_context_synchronously
        AppToaster.showToast(
          context: context,
          msg: "Review quán ăn thành công",
          type: AppToasterType.success,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          widget.restaurant != null
            ? "Chỉnh sửa thông tin"
            : "Review quán mới",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormFieldWidget(
                title: "Tên quán",
                hintText: "Nhập tên quán",
                controller: restaurantNameController,
              ),
              const SizedBox(
                height: 24,
              ),
              FormFieldWidget(
                title: "Địa chỉ",
                hintText: "Nhập địa chỉ quán",
                controller: addressController,
              ),
              const SizedBox(
                height: 24,
              ),
              FormFieldWidget(
                  title: "Định vị địa chỉ quán",
                  hintText: "Toạ độ của quán",
                  controller: locationController,
                  readOnly: true,
                  suffixIcon: InkWell(
                    onTap: () async {
                      final position =
                          await LocationService.getCurrentPosition();
                      if (position == null) {
                        print("Position null");
                      } else {
                        setState(() {
                          location = position;
                        });
                        print(
                            "Lat: ${position.latitude} --- long:${position.longitude}");
                        String positionStr =
                            "(${position.latitude}, ${position.longitude})";
                        locationController.text = positionStr;
                      }
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Thêm ảnh đại diện của quán",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: Stack(
                  children: [
                    widget.restaurant != null && restaurantAvatar == null
                      ? CachedImageWidget(
                          imageURL: widget.restaurant!.avatarUrl,
                          width: 160,
                          height: 160,
                          border: 12,
                        )
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: restaurantAvatar == null
                            ? Image.asset(
                                AssetPaths.imagePath.getDefaultLoadingImagePath,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                restaurantAvatar!,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                      ),
                    Positioned(
                      top: 60,
                      left: 60,
                      child: InkWell(
                        onTap: () async {
                          try {
                            File image = await SelectImage.selectImage();
                            setState(() {
                              restaurantAvatar = image;
                            });
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.4),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Thêm ảnh bìa của quán",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: Stack(
                  children: [
                    widget.restaurant != null && restaurantCoverImage == null
                      ? CachedImageWidget(
                          imageURL: widget.restaurant!.coverImageUrl,
                          width: 160,
                          height: 160,
                          border: 12,
                        )
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: restaurantCoverImage == null
                            ? Image.asset(
                                AssetPaths.imagePath.getDefaultLoadingImagePath,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                restaurantCoverImage!,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                      ),
                    Positioned(
                      top: 60,
                      left: 60,
                      child: InkWell(
                        onTap: () async {
                          try {
                            File image = await SelectImage.selectImage();
                            setState(() {
                              restaurantCoverImage = image;
                            });
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.4),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Review về quán",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                  scrollPadding: const EdgeInsets.all(8),
                  controller: reviewController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Cảm nhận của bạn về quán",
                    hintStyle: const TextStyle(
                        fontSize: 14, fontStyle: FontStyle.italic),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.greyBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.mainColor),
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Review về quán",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    NavigationService().pushNamed(ROUTE_REVIEW_FOOD);
                  },
                  child: const Text(
                    "Thêm món ăn mới",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.whiteColor,
                    backgroundColor: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    if (authViewModel.isLogin) {
                      onCreateOrUpdateRestaurant(authViewModel.currentUser!.id, authViewModel.token!);
                    }
                  },
                  child: const Text(
                    'Review',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
