import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getwidget/getwidget.dart';

import '../constants.dart';

class CustomRatingWidget extends StatefulWidget {
  const CustomRatingWidget({super.key});

  @override
  State<CustomRatingWidget> createState() => _CustomRatingWidgetState();
}

class _CustomRatingWidgetState extends State<CustomRatingWidget> {
  double _rating = 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "4.3",
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                RatingBarIndicator(
                  rating: 3.8,
                  itemCount: 5,
                  itemSize: 16,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: AppColors.yellowColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "200",
                  style: TextStyle(
                    color: AppColors.greyText,
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: Column(
                children: [
                  const CustomRatingProgress(
                    point: 5,
                    percent: 0.6,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const CustomRatingProgress(
                    point: 4,
                    percent: 0.2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const CustomRatingProgress(
                    point: 3,
                    percent: 0.1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const CustomRatingProgress(
                    point: 2,
                    percent: 0.05,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const CustomRatingProgress(
                    point: 1,
                    percent: 0.05,
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
              (states) => AppColors.mainColor,
            ),
          ),
          onPressed: () {},
          child: const Text(
            "Đăng nhập để đánh giá",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        GFRating(
          spacing: 20,
          color: AppColors.yellowColor,
          borderColor: AppColors.yellowColor,
          value: _rating,
          onChanged: (value) {
            setState(() {
              _rating = value;
            });
          },
        ),
      ],
    );
  }
}

class CustomRatingProgress extends StatelessWidget {
  const CustomRatingProgress({
    super.key,
    required this.point,
    required this.percent,
  });

  final int point;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$point",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: GFProgressBar(
            lineHeight: 8,
            percentage: percent,
            backgroundColor: AppColors.greyBackground,
            progressBarColor: AppColors.mainColor,
          ),
        ),
      ],
    );
  }
}
