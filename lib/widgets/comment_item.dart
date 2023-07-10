import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/widgets/shimmer_loading.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/comment.dart';
import '../utils/utils.dart';
import '../view_models/user_view_model.dart';
import 'cached_image_widget.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;
  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder(
                future: context.read<UserViewModel>().getUserById(comment.userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    if (user != null) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          user.avatarUrl != null
                            ? CachedImageWidget(
                                imageURL: user.avatarUrl!,
                                width: 40,
                                height: 40,
                                border: 20,
                              )
                            : Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(AssetPaths
                                        .imagePath.getDefaultUserImagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.username,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                Utils.convertDateTime(comment.createdAt),
                                style: const TextStyle(color: AppColors.subTitleColor),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ShimmerLoading(
                        width: 40,
                        height: 40,
                        border: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ShimmerLoading(width: 100, height: 16, border: 4),
                          Text(
                            Utils.convertDateTime(comment.createdAt),
                            style: const TextStyle(color: AppColors.subTitleColor),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${comment.likedUserIdList.length}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Like");
                    },
                    child: Image.asset(
                      AssetPaths.iconPath.getLikeFillIconPath,
                      width: 14,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${comment.dislikedUserIdList.length}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Dislike");
                    },
                    child: Image.asset(
                      AssetPaths.iconPath.getDislikeFillIconPath,
                      width: 14,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            comment.content,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
