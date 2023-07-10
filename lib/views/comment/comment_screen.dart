import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/models/comment.dart';
import 'package:hanoi_foodtour/view_models/comment_view_model.dart';
import 'package:hanoi_foodtour/widgets/comment_item.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.objectId, required this.type});
  final String objectId;
  final String type;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bình luận"),
      ),
      body: MyListWidget(objectId: widget.objectId, type: widget.type,),
    );
  }
}

class MyListWidget extends StatefulWidget {
  const MyListWidget({super.key, required this.objectId, required this.type});
  final String objectId;
  final String type;

  @override
  _MyListWidgetState createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> {
  late ScrollController _scrollController;
  List<Comment> _dataList = [];
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
      if (!isLoadFull) {
        _loadData();
      }
    }
  }

  Future<void> _loadData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Gọi API để tải dữ liệu mới
      // Ở đây, bạn có thể sử dụng package http, Dio, hoặc các công cụ khác để gọi API
      // Ví dụ:
      // var newData = await apiCall(_page);

      // Giả định dữ liệu trả về từ API là danh sách các item dạng String
      var newData = await context.read<CommentViewModel>().getComment(widget.type, widget.objectId, 10, page: _page);

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
                CommentItem(comment: _dataList[index],),
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