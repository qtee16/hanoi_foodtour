import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';

class ListItem extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;
  const ListItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: AppColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(icon, width: 20, height: 20, fit: BoxFit.cover,),
            const SizedBox(
              width: 16,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
