import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/restaurant.dart';
import '../routes/navigation_services.dart';
import '../routes/routes.dart';
import '../view_models/like_view_model.dart';
import 'cached_image_widget.dart';

class RestaurantCardItem extends StatefulWidget {
  const RestaurantCardItem({
    super.key,
    required this.restaurant,
  });
  final Restaurant restaurant;

  @override
  State<RestaurantCardItem> createState() => _RestaurantCardItemState();
}

class _RestaurantCardItemState extends State<RestaurantCardItem> {
  List likedData = [];

  @override
  void initState() {
    super.initState();
    updateLike();
  }

  updateLike() async {
    final newLikes = await context.read<LikeViewModel>().getAllLike(widget.restaurant.id, "restaurant");
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
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            Container(
              decoration: const BoxDecoration(color: AppColors.greyBackground),
              child: CupertinoActionSheetAction(
                onPressed: () { 
                  // do jump to message
                  // Utils.jumpToMessageFromMedia(context, item, isDirect: isDirect);
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
                  // do jump to message
                  // Utils.jumpToMessageFromMedia(context, item, isDirect: isDirect);
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
          ROUTE_RESTAURANT_DETAIL,
          arguments: {
            "restaurant": widget.restaurant,
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
              imageURL: widget.restaurant.avatarUrl,
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
                    widget.restaurant.restaurantName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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
                            widget.restaurant.rating == 0
                                ? "Chưa có đánh giá"
                                : "${widget.restaurant.rating} (${widget.restaurant.countRatings})",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AssetPaths.iconPath.getLocationIconPath,
                        width: 14,
                        height: 14,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          widget.restaurant.address,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
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