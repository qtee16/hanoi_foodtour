import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/services/select_image.dart';

import '../../widgets/form_field_widget.dart';
import '../../widgets/multi_select.dart';

class ReviewFoodScreen extends StatefulWidget {
  const ReviewFoodScreen({super.key});

  @override
  State<ReviewFoodScreen> createState() => _ReviewFoodScreenState();
}

class _ReviewFoodScreenState extends State<ReviewFoodScreen> {
  final foodNameController = TextEditingController();
  final costController = TextEditingController();
  final locationController = TextEditingController();
  final reviewController = TextEditingController();

  List _selectCategories = [];
  File? restaurantAvatar;
  File? restaurantCoverImage;

  void _showMultiSelect(
    List categories,
  ) async {
    final results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(title: "Chọn danh mục", items: categories);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectCategories = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: const Text(
            "Review món mới",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                  controller: costController,
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
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.whiteColor,
                      backgroundColor: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () async {
                      List categories = ["Phở", "Bún", "Mỳ", "Cơm"];
                      _showMultiSelect(
                        categories,
                      );
                    },
                    child: const Text(
                      'Chọn',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Wrap(
                  children: _selectCategories
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.only(bottom: 4, right: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.mainColor,
                          ),
                          child: Text(
                            e,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor),
                          ),
                        ),
                      )
                      .toList(),
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
                      ClipRRect(
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
                                // AppToaster.showToast(
                                //   context: context,
                                //   msg: ConstantStrings
                                //       .appString.needAcceptReadRule,
                                //   type: AppToasterType.warning,
                                // );
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
                // const Text("Thêm ảnh bìa của quán", style: TextStyle(fontWeight: FontWeight.bold),),
                // const SizedBox(height: 8,),
                // Center(
                //   child: Stack(
                //     children: [
                //       ClipRRect(
                //         borderRadius: BorderRadius.circular(12),
                //         child: restaurantCoverImage == null
                //           ? Image.asset(
                //               AssetPaths.imagePath.getDefaultLoadingImagePath,
                //               width: 160,
                //               height: 160,
                //               fit: BoxFit.cover,
                //             )
                //           : Image.file(
                //             restaurantCoverImage!,
                //             width: 160,
                //             height: 160,
                //             fit: BoxFit.cover,
                //           ),
                //       ),
                //       Positioned(
                //         top: 60,
                //         left: 60,
                //         child: InkWell(
                //           onTap: () async {
                //             try {
                //               File image = await SelectImage.selectImage();
                //               setState(() {
                //                 restaurantCoverImage = image;
                //               });
                //             } on PlatformException catch (e) {
                //               if (e.code ==
                //                   'read_external_storage_denied') {
                //                 // AppToaster.showToast(
                //                 //   context: context,
                //                 //   msg: ConstantStrings
                //                 //       .appString.needAcceptReadRule,
                //                 //   type: AppToasterType.warning,
                //                 // );
                //               }
                //             }
                //           },
                //           child: Container(
                //             width: 40,
                //             height: 40,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(20),
                //               color: Colors.white.withOpacity(0.4),
                //             ),
                //             child: const Icon(
                //               Icons.camera_alt,
                //               color: AppColors.whiteColor,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 16,),
                const Text(
                  "Review về món ăn",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                    scrollPadding: EdgeInsets.all(8),
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
                    onPressed: () async {},
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
        ));
  }
}