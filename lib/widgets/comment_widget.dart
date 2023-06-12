import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/widgets/cached_image_widget.dart';

import '../constants.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final FocusNode _focusNode = FocusNode();
  final commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
              (states) => AppColors.mainColor,
            ),
          ),
          onPressed: () {},
          child: const Text(
            "Đăng nhập để bình luận",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: commentController,
          focusNode: _focusNode,
          minLines: 3,
          maxLines: 5,
          textInputAction: TextInputAction.done,
          onEditingComplete: () {
            _focusNode.unfocus();
          },
          decoration: InputDecoration(
            hintText: "Viết bình luận",
            hintStyle: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: AppColors.greyText,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.greyBorder),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedImageWidget(
                      imageURL:
                          "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80",
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
                        Text(
                          "Thang Tran",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "16:00",
                          style: TextStyle(color: AppColors.subTitleColor),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "15",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Image.asset(
                      AssetPaths.iconPath.getLikeFillIconPath,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "15",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Image.asset(
                      AssetPaths.iconPath.getDislikeFillIconPath,
                      width: 18,
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
