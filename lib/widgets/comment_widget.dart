import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/widgets/cached_image_widget.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../view_models/auth_view_model.dart';

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
    final authViewModel = Provider.of<AuthViewModel>(context);
    final isLogin = authViewModel.isLogin;

    return Column(
      children: [
        isLogin
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                    height: 8,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.mainColor,
                      ),
                    ),
                    onPressed: () {
                      // NavigationService().pushNamed(ROUTE_SIGN_IN);
                    },
                    child: const Text(
                      "Gửi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              )
            : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.mainColor,
                  ),
                ),
                onPressed: () {
                  NavigationService().pushNamed(ROUTE_SIGN_IN);
                },
                child: const Text(
                  "Đăng nhập để bình luận",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
        const SizedBox(
          height: 32,
        ),
        Divider(
          height: 0.5,
          thickness: 0.5,
          color: AppColors.greyBorder,
        ),
        CommentItem(),
        Divider(
          height: 0.5,
          thickness: 0.5,
          color: AppColors.greyBorder,
        ),
        CommentItem(),
        Divider(
          height: 0.5,
          thickness: 0.5,
          color: AppColors.greyBorder,
        ),
        CommentItem(),
        Divider(
          height: 0.5,
          thickness: 0.5,
          color: AppColors.greyBorder,
        ),
        const SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: () {
            NavigationService().pushNamed(ROUTE_COMMENT);
          },
          child: Text(
            "Xem tất cả bình luận",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: TextStyle(fontSize: 14),
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
                    "15",
                    style: TextStyle(fontSize: 14),
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
            "Món ăn này rất ngonn.",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
