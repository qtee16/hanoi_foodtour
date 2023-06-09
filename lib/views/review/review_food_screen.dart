import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/services/select_image.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/view_models/food_view_model.dart';
import 'package:hanoi_foodtour/widgets/cached_image_widget.dart';
import 'package:provider/provider.dart';

import '../../models/food.dart';
import '../../routes/navigation_services.dart';
import '../../utils/utils.dart';
import '../../widgets/app_toaster.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/form_field_widget.dart';

class ReviewFoodScreen extends StatefulWidget {
  final String restaurantId;
  final Food? food;
  const ReviewFoodScreen({super.key, required this.restaurantId, this.food});

  @override
  State<ReviewFoodScreen> createState() => _ReviewFoodScreenState();
}

class _ReviewFoodScreenState extends State<ReviewFoodScreen> {
  final foodNameController = TextEditingController();
  final priceController = TextEditingController();
  final reviewController = TextEditingController();

  List<int> categories = [1, 2, 3, 4, 5, 6];
  int? selectCategory;
  File? foodImage;
  Map<String, dynamic>? updateData;

  @override
  void initState() {
    super.initState();
    if (widget.food != null) {
      foodNameController.text = widget.food!.foodName;
      priceController.text = widget.food!.price.toString();
      reviewController.text = widget.food!.review;
      selectCategory = widget.food!.category;
      updateData = {
        "userId": widget.food!.userId,
      };
    }
  }

  onCreateOrUpdateFood(String userId, String token) async {
    if (widget.food != null) {
      bool isChanged = false;
      final foodName = foodNameController.text.trim();
      final price = priceController.text.trim();
      final review = reviewController.text.trim();
      if (foodName != widget.food!.foodName) {
        updateData!["foodName"] = foodName;
        isChanged = true;
      }
      if (double.parse(price) != widget.food!.price) {
        updateData!["price"] = double.parse(price);
        isChanged = true;
      }
      if (review != widget.food!.review) {
        updateData!["review"] = review;
        isChanged = true;
      }
      if (selectCategory != widget.food!.category) {
        updateData!["category"] = selectCategory;
        isChanged = true;
      }
      if (foodImage != null) {
        isChanged = true;
      }
      if (isChanged) {
        // ignore: use_build_context_synchronously
        showAppLoading(context);
        // ignore: use_build_context_synchronously
        await context.read<FoodViewModel>().updateFood(
          foodImage,
          widget.food!.id,
          updateData!,
          token,
        );
        NavigationService().pop();
        NavigationService().pop();
        // ignore: use_build_context_synchronously
        AppToaster.showToast(
          context: context,
          msg: "Chỉnh sửa món ăn thành công",
          type: AppToasterType.success,
        );
      }
    } else {
      if (foodImage != null) {
        final foodName = foodNameController.text.trim();
        final price = priceController.text.trim();
        final review = reviewController.text.trim();
        final data = {
          "userId": userId,
          "restaurantId": widget.restaurantId,
          "foodName": foodName,
          "category": selectCategory,
          "review": review,
          "price": price,
        };
        // ignore: use_build_context_synchronously
        showAppLoading(context);
        // ignore: use_build_context_synchronously
        await context.read<FoodViewModel>().createFood(
          foodImage!,
          data,
          token,
        );
        NavigationService().pop();
        NavigationService().pop();
        // ignore: use_build_context_synchronously
        AppToaster.showToast(
          context: context,
          msg: "Review món ăn thành công",
          type: AppToasterType.success,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.read<AuthViewModel>();

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: Text(
            widget.food != null
              ? "Chỉnh sửa thông tin"
              : "Review món mới",
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
                  title: "Tên món ăn",
                  hintText: "Nhập tên món ăn",
                  controller: foodNameController,
                ),
                const SizedBox(
                  height: 24,
                ),
                FormFieldWidget(
                  title: "Giá tiền",
                  hintText: "Nhập giá tiền của món ăn",
                  controller: priceController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "Danh mục món ăn",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomDropdown<int>(
                  buttonHeight: 48,
                  buttonWidth: double.infinity,
                  dropdownWidth: MediaQuery.of(context).size.width - 32,
                  hint: 'Chọn danh mục món ăn',
                  valueAlignment: Alignment.center,
                  dropdownItems: categories,
                  value: selectCategory,
                  onChanged: (dynamic value) {
                    setState(() {
                      selectCategory = value;
                    });
                  },
                  items: categories
                      .map((item) => DropdownMenuItem<int>(
                            value: item,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Utils.categoriesMap[item].toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  itemHeight: 48,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Thêm ảnh của món ăn",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: Stack(
                    children: [
                      widget.food != null && foodImage == null
                        ? CachedImageWidget(
                            imageURL: widget.food!.imageUrl,
                            width: 160,
                            height: 160,
                            border: 12,
                          )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: foodImage == null
                              ? Image.asset(
                                  AssetPaths.imagePath.getDefaultLoadingImagePath,
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  foodImage!,
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
                              File? image = await SelectImage.selectImage();
                              if (image != null) {
                                setState(() {
                                  foodImage = image;
                                });
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
                  "Review về món ăn",
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
                      hintText: "Cảm nhận của bạn về món ăn",
                      hintStyle: const TextStyle(
                          fontSize: 14, fontStyle: FontStyle.italic),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.greyBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.mainColor),
                      ),
                    )),
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
                    onPressed: () async {
                      onCreateOrUpdateFood(authViewModel.currentUser!.id, authViewModel.token!);
                    },
                    child: Text(
                      widget.food != null ? "Xác nhận" : 'Review',
                      style: const TextStyle(
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
        ));
  }
}
