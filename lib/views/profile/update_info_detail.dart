import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/user.dart';

class UpdateInfoDetail extends StatefulWidget {
  const UpdateInfoDetail({
    super.key,
    required this.title,
    required this.type,
  });
  final String title;
  final String type;

  @override
  State<UpdateInfoDetail> createState() => _UpdateInfoDetailState();
}

class _UpdateInfoDetailState extends State<UpdateInfoDetail> {
  late TextEditingController controller;
  late String currentValue;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    User currentUser = context.read<AuthViewModel>().currentUser!;
    if (widget.type == "name") {
      controller.text = currentUser.username;
    } else if (widget.type == "email") {
      controller.text = currentUser.email;
    }
    currentValue = controller.text.trim();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  String getFormTitle() {
    switch (widget.type) {
      case "name":
        return "Tên";
      case "email":
        return "Email";
      default:
        return "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 24),
        color: AppColors.whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.greyColor,
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getFormTitle(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.greyTitle,
                    ),
                  ),
                  const SizedBox(height: 6,),
                  TextFormField(
                    style: const TextStyle(fontSize: 16),
                    controller: controller,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD9D9D9))
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD9D9D9))
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.whiteColor,
                  backgroundColor: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () async {
                  final value = controller.text.trim();
                  if (value.isNotEmpty && value != currentValue) {
                    String field = "";
                    if (widget.type == "name") {
                      field = "username";
                    } else if (widget.type == "email") {
                      field = "email";
                    }
                    final data = {
                      field: value,
                    };
                    final auth = context.read<AuthViewModel>();
                    User user = await context.read<UserViewModel>().updateUser(auth.currentUser!.id, data, auth.token!);
                    auth.setCurrentUser(user);
                    NavigationService().pop();
                  }
                },
                child: const Text(
                  'Lưu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}