import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../routes/navigation_services.dart';
import '../../widgets/comment_widget.dart';
import '../../widgets/content_container.dart';
import '../../widgets/custom_rating_widget.dart';
import '../../widgets/list_card_item.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: maxWidth,
                height: 360,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.network(
                        "https://owa.bestprice.vn/images/articles/uploads/an-sach-15-quan-pho-ngon-re-o-ha-noi-5f6c02a1e0b66.jpg",
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 240,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 180,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 160,
                        width: 300,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Phở bò tái chín", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),), 
                            const SizedBox(height: 12,),
                            Text("35.000 VND", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                            const SizedBox(height: 12,),
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      AssetPaths.iconPath.getStarIconPath,
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      "4.3 (100 đánh giá)",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      AssetPaths.iconPath.getHeartIconPath,
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      "50",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  AssetPaths.iconPath.getLocationIconPath,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: const Text(
                                    "Ngõ 50 Tạ Quang Bửu, Hai Bà Trưng",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: InkWell(
                        onTap: () {
                          NavigationService().pop();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromRGBO(255, 255, 255, 0.5),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   padding: const EdgeInsets.only(
                  //     top: 16,
                  //     left: 16,
                  //     right: 16,
                  //     bottom: 16,
                  //   ),
                  //   width: MediaQuery.of(context).size.width,
                  //   color: AppColors.whiteColor,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text(
                  //         "Phở Bát Đàn",
                  //         style: TextStyle(
                  //             fontSize: 24, fontWeight: FontWeight.bold),
                  //       ),
                  //       const SizedBox(
                  //         height: 12,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Image.asset(
                  //             AssetPaths.iconPath.getLocationIconPath,
                  //             width: 20,
                  //             height: 20,
                  //             fit: BoxFit.cover,
                  //             filterQuality: FilterQuality.high,
                  //           ),
                  //           const SizedBox(
                  //             width: 4,
                  //           ),
                  //           Container(
                  //             width: 300,
                  //             child: const Text(
                  //               "Ngõ 50 Tạ Quang Bửu, Hai Bà Trưng",
                  //               overflow: TextOverflow.ellipsis,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(
                  //         height: 8,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Image.asset(
                  //             AssetPaths.iconPath.getStarIconPath,
                  //             width: 20,
                  //             height: 20,
                  //             fit: BoxFit.cover,
                  //             filterQuality: FilterQuality.high,
                  //           ),
                  //           const SizedBox(
                  //             width: 4,
                  //           ),
                  //           Container(
                  //             width: 300,
                  //             child: const Text(
                  //               "4.3 (100 đánh giá)",
                  //               overflow: TextOverflow.ellipsis,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(
                  //         height: 8,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Image.asset(
                  //             AssetPaths.iconPath.getHeartIconPath,
                  //             width: 20,
                  //             height: 20,
                  //             fit: BoxFit.cover,
                  //             filterQuality: FilterQuality.high,
                  //           ),
                  //           const SizedBox(
                  //             width: 4,
                  //           ),
                  //           Container(
                  //             width: 300,
                  //             child: const Text(
                  //               "50",
                  //               overflow: TextOverflow.ellipsis,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(
                  //         height: 16,
                  //       ),
                  //       const Text(
                  //         "Danh mục món ăn",
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         height: 8,
                  //       ),
                  //       Wrap(
                  //         children: [
                  //           Container(
                  //             margin:
                  //                 const EdgeInsets.only(bottom: 4, right: 4),
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 12, vertical: 8),
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(16),
                  //                 color: Colors.orange),
                  //             child: Text(
                  //               "Phở",
                  //               style: const TextStyle(
                  //                   color: AppColors.whiteColor),
                  //             ),
                  //           ),
                  //           Container(
                  //             margin:
                  //                 const EdgeInsets.only(bottom: 4, right: 4),
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 12, vertical: 8),
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(16),
                  //                 color: Colors.orange),
                  //             child: Text(
                  //               "Phở",
                  //               style: const TextStyle(
                  //                   color: AppColors.whiteColor),
                  //             ),
                  //           ),
                  //           Container(
                  //             margin:
                  //                 const EdgeInsets.only(bottom: 4, right: 4),
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 12, vertical: 8),
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(16),
                  //                 color: Colors.orange),
                  //             child: Text(
                  //               "Phở",
                  //               style: const TextStyle(
                  //                   color: AppColors.whiteColor),
                  //             ),
                  //           ),
                  //           Container(
                  //             margin:
                  //                 const EdgeInsets.only(bottom: 4, right: 4),
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 12, vertical: 8),
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(16),
                  //                 color: Colors.orange),
                  //             child: Text(
                  //               "Phở",
                  //               style: const TextStyle(
                  //                   color: AppColors.whiteColor),
                  //             ),
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.whiteColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Review",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                            "Nước dùng ngọt, đậm vị. Sợi phở dai, ngon. Thịt bò được nấu vừa tái chín, không quá dai. Có 3 option 30.000 - 35.000 - 40.000.")
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const ListCardItem(
                title: "Những món ăn khác của quán",
                subTitle: "Khám phá các món ăn đa dạng",
              ),
              const SizedBox(
                height: 8,
              ),
              const ContentContainer(
                title: "Đánh giá",
                contentWidget: CustomRatingWidget(),
              ),
              const SizedBox(
                height: 8,
              ),
              const ContentContainer(
                title: "Bình luận",
                contentWidget: CommentWidget(),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: AppColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.whiteColor),
                  side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(color: Colors.red))),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset(
                    AssetPaths.iconPath.getHeartIconPath,
                    width: 16,
                    height: 16,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Yêu thích",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.mainColor),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset(
                    AssetPaths.iconPath.getRouteIconPath,
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Tìm đường",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
