import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/models/food.dart';
import 'package:hanoi_foodtour/view_models/food_view_model.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../routes/navigation_services.dart';
import '../routes/routes.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/like_view_model.dart';
import 'app_toaster.dart';
import 'cached_image_widget.dart';
import 'custom_loading.dart';

class FoodCardItem extends StatefulWidget {
  const FoodCardItem({super.key, required this.food});
  final Food food;

  @override
  State<FoodCardItem> createState() => _FoodCardItemState();
}

class _FoodCardItemState extends State<FoodCardItem> {
  List likedData = [];

  @override
  void initState() {
    super.initState();
    updateLike();
  }

  updateLike() async {
    final newLikes = await context.read<LikeViewModel>().getAllLike(widget.food.id, "food");
    setState(() {
      likedData = List.from(newLikes);
    });
  }

  renderTextAndIconDialog({icon, title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        icon,
        const SizedBox(width: 20),
        Text(title, style: const TextStyle(color: AppColors.blackColor, fontSize: 18)),
      ],
    );
  }

  _showBottomOption() {
    showCupertinoModalPopup(
      context: context, 
      builder: (subContext) {
        final authViewModel = context.read<AuthViewModel>();
        return CupertinoActionSheet(
          actions: [
            Container(
              decoration: const BoxDecoration(color: AppColors.greyBackground),
              child: CupertinoActionSheetAction(
                onPressed: () {
                  NavigationService().pop();
                  NavigationService().pushNamed(
                    ROUTE_REVIEW_FOOD,
                    arguments: {
                      "restaurantId": widget.food.restaurantId,
                      "food" : widget.food,
                    },
                  );
                },
                child: renderTextAndIconDialog(
                  icon: const Icon(Icons.edit,),
                  title: "Chỉnh sửa"
                )
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: AppColors.greyBackground),
              child: CupertinoActionSheetAction(
                onPressed: () {
                  NavigationService().pop();
                  showCupertinoDialog(
                    context: context,
                    builder: (subContext) {
                      return CupertinoAlertDialog(
                        title: const Text("Xoá quán ăn"),
                        content: const Text("Bạn có chắc chắn muốn xoá quán ăn?"),
                        actions: [
                          CupertinoButton(
                            child: const Text("Xoá"),
                            onPressed: () async {
                              NavigationService().pop();
                              showAppLoading(context);
                              // ignore: use_build_context_synchronously
                              await context
                                  .read<FoodViewModel>()
                                  .deleteFood(
                                    widget.food.id,
                                    authViewModel.currentUser!.id,
                                    authViewModel.token!,
                                  );
                              NavigationService().pop();
                              // ignore: use_build_context_synchronously
                              AppToaster.showToast(
                                context: context,
                                msg: "Xoá quán ăn thành công",
                                type: AppToasterType.success,
                              );
                            },
                          ),
                          CupertinoButton(
                            child: const Text("Huỷ", style: TextStyle(color: AppColors.redColor),),
                            onPressed: () {
                              NavigationService().pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: renderTextAndIconDialog(
                  icon: const Icon(Icons.delete,),
                  title: "Xoá"
                )
              ),
            ),
          ],
          cancelButton: Container(
            decoration: BoxDecoration(color: AppColors.greyBackground, borderRadius: BorderRadius.circular(10)),
            child: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Huỷ')),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        _showBottomOption();
      },
      onTap: () {
        NavigationService().pushNamed(
          ROUTE_FOOD_DETAIL,
          arguments: {
            "food": widget.food,
            "likedData": likedData,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        width: double.infinity,
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedImageWidget(
              width: 80,
              height: 80,
              border: 8,
              imageURL: widget.food.imageUrl,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.food.foodName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        AssetPaths.iconPath.getCoinIconPath,
                        width: 14,
                        height: 14,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${widget.food.price} VND",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AssetPaths.iconPath.getStarIconPath,
                            width: 14,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.food.rating == 0
                                ? "Chưa có đánh giá"
                                : "${widget.food.rating} (${widget.food.countRatings})",
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AssetPaths.iconPath.getHeartIconPath,
                            width: 14,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            likedData.length.toString(),
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}