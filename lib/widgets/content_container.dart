import 'package:flutter/material.dart';

import '../constants.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.title,
    required this.contentWidget,
  });
  final String title;
  final Widget contentWidget;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return Container(
      width: maxWidth,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          contentWidget
        ],
      ),
    );
  }
}
