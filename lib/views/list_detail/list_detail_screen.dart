import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/view_models/food_view_model.dart';
import 'package:hanoi_foodtour/view_models/restaurant_view_model.dart';
import 'package:hanoi_foodtour/widgets/food_card_item.dart';
import 'package:hanoi_foodtour/widgets/restaurant_card_item.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class ListDetailScreen extends StatefulWidget {
  ListDetailScreen({
    super.key,
    required this.title,
    required this.type,
    this.isFood = true,
    this.data,
  });
  final String title;
  final String type;
  final bool isFood;
  List? data;

  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      ),
      body: MyListWidget(isFood: widget.isFood, data: widget.data,),
    );
  }
}

// ignore: must_be_immutable
class MyListWidget extends StatefulWidget {
  MyListWidget({
    super.key,
    required this.isFood,
    this.data,
  });
  final bool isFood;
  List? data;

  @override
  // ignore: library_private_types_in_public_api
  _MyListWidgetState createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> {
  late ScrollController _scrollController;
  List _dataList = [];
  int _page = 0;
  bool _isLoading = false;
  double _scrollPosition = 0.0;
  bool isLoadFull = false;

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController = ScrollController(initialScrollOffset: _scrollPosition);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
      // Scroll đến cuối danh sách
      _scrollPosition = _scrollController.position.maxScrollExtent;
      if (!isLoadFull && widget.data != null) {
        _loadData();
      }
    }
  }

  Future<void> _loadData() async {
    if (widget.data != null) {
      setState(() {
        _dataList.addAll(widget.data!);
      });
    } else {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });

        // Gọi API để tải dữ liệu mới
        // Ở đây, bạn có thể sử dụng package http, Dio, hoặc các công cụ khác để gọi API
        // Ví dụ:
        // var newData = await apiCall(_page);

        // Giả định dữ liệu trả về từ API là danh sách các item dạng String
        var newData = [];
        if (widget.isFood) {
          newData = await context.read<FoodViewModel>().getTopRatingFoods(10, page: _page);
        } else {
          newData = await context.read<RestaurantViewModel>().getTopRatingRestaurants(10, page: _page);
        }

        setState(() {
          _dataList.addAll(newData);
          _page++;
          _isLoading = false;
          if (newData.length < 10) {
            isLoadFull = true;
          }
        });
        _scrollController.jumpTo(_scrollPosition);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("REBUILD");
    return ListView.builder(
      controller: _scrollController,
      itemCount: _dataList.length + 1,
      itemBuilder: (context, index) {
        if (index < _dataList.length) {
          return Column(
              children: [
                const Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: AppColors.greyBorder,
                ),
                widget.isFood
                  ? FoodCardItem(food: _dataList[index])
                  : RestaurantCardItem(restaurant: _dataList[index])
              ],
            );
        } else {
          return _buildLoader();
        }
      },
    );
  }

  Widget _buildLoader() {
    return _isLoading
        ? const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container();
  }
}