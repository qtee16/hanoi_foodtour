import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/rating.dart';
import '../routes/navigation_services.dart';
import '../routes/routes.dart';
import '../view_models/auth_view_model.dart';

// ignore: must_be_immutable
class CustomRatingWidget extends StatefulWidget {
  final double currentRating;
  final int countRating;
  final Function onRating;
  double? myRating;
  List<Rating> ratings;

  CustomRatingWidget({
    super.key,
    required this.currentRating,
    required this.countRating,
    this.myRating,
    required this.ratings,
    required this.onRating,
  });

  @override
  State<CustomRatingWidget> createState() => _CustomRatingWidgetState();
}

class _CustomRatingWidgetState extends State<CustomRatingWidget> {
  double _rating = 0;
  bool isLoadedCurrentRating = false;

  processRating() {
    final totalRating = widget.ratings.length;
    if (totalRating != 0) {
      final count5Ratings = widget.ratings
          .where((element) => element.rating == 5)
          .toList()
          .length;
      final percent5Ratings = count5Ratings / totalRating;
      final count4Ratings = widget.ratings
          .where((element) => element.rating == 4)
          .toList()
          .length;
      final percent4Ratings = count4Ratings / totalRating;
      final count3Ratings = widget.ratings
          .where((element) => element.rating == 3)
          .toList()
          .length;
      final percent3Ratings = count3Ratings / totalRating;
      final count2Ratings = widget.ratings
          .where((element) => element.rating == 2)
          .toList()
          .length;
      final percent2Ratings = count2Ratings / totalRating;
      final percent1Ratings = 1 -
          percent2Ratings -
          percent3Ratings -
          percent4Ratings -
          percent5Ratings;
      final mapRating = {
        "5": percent5Ratings,
        "4": percent4Ratings,
        "3": percent3Ratings,
        "2": percent2Ratings,
        "1": percent1Ratings,
      };
      return mapRating;
    }
    return {
      "5": 0.0,
      "4": 0.0,
      "3": 0.0,
      "2": 0.0,
      "1": 0.0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final isLogin = authViewModel.isLogin;
    if (widget.myRating != null && !isLoadedCurrentRating) {
      _rating = widget.myRating!;
      isLoadedCurrentRating = true;
      print("FETCH: ${widget.myRating}");
    }

    final ratingsData = processRating();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.countRating == 0
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chưa có đánh giá",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            : Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.currentRating}",
                        style: const TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      RatingBarIndicator(
                        rating: widget.currentRating,
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
                      Text(
                        "${widget.countRating}",
                        style: const TextStyle(
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
                        CustomRatingProgress(
                          point: 5,
                          percent: ratingsData["5"],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomRatingProgress(
                          point: 4,
                          percent: ratingsData["4"],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomRatingProgress(
                          point: 3,
                          percent: ratingsData["3"],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomRatingProgress(
                          point: 2,
                          percent: ratingsData["2"],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomRatingProgress(
                          point: 1,
                          percent: ratingsData["1"],
                        ),
                      ],
                    ),
                  )
                ],
              ),
        const SizedBox(
          height: 16,
        ),
        isLogin
            ? Column(
                children: [
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
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.mainColor,
                      ),
                    ),
                    onPressed: () async {
                      widget.onRating(_rating);
                    },
                    child: const Text(
                      "Đánh giá",
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
                  "Đăng nhập để đánh giá",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
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
          style: const TextStyle(fontWeight: FontWeight.w600),
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
