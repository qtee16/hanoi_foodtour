import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/comment_view_model.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/comment.dart';
import '../view_models/auth_view_model.dart';
import 'comment_item.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.objectId,
    required this.type,
  });

  final String objectId;
  final String type;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final FocusNode _focusNode = FocusNode();
  final commentController = TextEditingController();

  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    getLimitComment(6);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    commentController.dispose();
  }

  getLimitComment(int limit) async {
    List<Comment> result = [];
    result = await context.read<CommentViewModel>().getComment(widget.type, widget.objectId, limit);
    if (result.isNotEmpty) {
      setState(() {
        comments = List.from(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final isLogin = authViewModel.isLogin;

    final displayComments = comments.length >= 6 ? comments.sublist(0, 5) : comments;

    return Column(
      children: [
        isLogin
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,),
              child: Column(
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
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: AppColors.greyText,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.greyBorder),
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
                      onPressed: () async {
                        final content = commentController.text.trim();
                        if (content.isNotEmpty) {
                          commentController.clear();
                          final data = {
                            "userId": authViewModel.currentUser!.id,
                            "content": content,
                          };
                          Comment comment = 
                            await context.read<CommentViewModel>().sendComment(widget.type, data, widget.objectId, authViewModel.token!);
                          setState(() {
                            comments.insert(0, comment);
                          });
                        }
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
                ),
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
        SizedBox(
          height: comments.isNotEmpty ? 32 : 0,
        ),
        Column(
          children: displayComments.map((e) {
            return Column(
              children: [
                const Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: AppColors.greyBorder,
                ),
                CommentItem(comment: e,),
              ],
            );
          }).toList(),
        ),
        comments.isNotEmpty
          ? const Divider(
            height: 0.5,
            thickness: 0.5,
            color: AppColors.greyBorder,
          )
          : const SizedBox(),
        SizedBox(
          height: comments.isNotEmpty ? 16 : 0,
        ),
        comments.length > 5
          ? TextButton(
            onPressed: () {
              NavigationService().pushNamed(
                ROUTE_COMMENT,
                arguments: {
                  "objectId": widget.objectId,
                  "type": widget.type,
                },
              );
            },
            child: const Text(
              "Xem tất cả bình luận",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
          : const SizedBox(),
      ],
    );
  }
}