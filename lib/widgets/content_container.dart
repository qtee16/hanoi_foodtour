import 'package:flutter/material.dart';

import '../constants.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.title,
    required this.contentWidget,
    this.isCommentWidget = false,
  });
  final String title;
  final Widget contentWidget;
  final bool isCommentWidget;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return Container(
      width: maxWidth,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(vertical: 16,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isCommentWidget ? 0 : 16),
            child: contentWidget,
          )
        ],
      ),
    );
  }
}
