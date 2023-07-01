import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/models/food.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../routes/navigation_services.dart';
import '../routes/routes.dart';
import '../view_models/like_view_model.dart';
import 'cached_image_widget.dart';

// class FoodCardItem extends StatelessWidget {
//   const FoodCardItem({
//     super.key,
//     required this.food,
//   });
//   final Food food;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         NavigationService().pushNamed(
//           ROUTE_FOOD_DETAIL,
//           arguments: {
//             "food": food,
//           },
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         width: double.infinity,
//         height: 100,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CachedImageWidget(
//               width: 80,
//               height: 80,
//               border: 8,
//               imageURL: food.imageUrl,
//             ),
//             const SizedBox(
//               width: 16,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     food.foodName,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Image.asset(
//                         AssetPaths.iconPath.getCoinIconPath,
//                         width: 14,
//                         height: 14,
//                         fit: BoxFit.cover,
//                       ),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       Text(
//                         "${food.price} VND",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             AssetPaths.iconPath.getStarIconPath,
//                             width: 14,
//                             height: 14,
//                             fit: BoxFit.cover,
//                             filterQuality: FilterQuality.high,
//                           ),
//                           const SizedBox(
//                             width: 4,
//                           ),
//                           Text(
//                             food.rating == 0
//                                 ? "Chưa có đánh giá"
//                                 : "${food.rating} (${food.countRatings})",
//                             style: const TextStyle(fontSize: 12),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             AssetPaths.iconPath.getHeartIconPath,
//                             width: 14,
//                             height: 14,
//                             fit: BoxFit.cover,
//                             filterQuality: FilterQuality.high,
//                           ),
//                           const SizedBox(
//                             width: 4,
//                           ),
//                           Text(
//                             food.likedUserIdList.length.toString(),
//                             style: const TextStyle(fontSize: 12),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
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