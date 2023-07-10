import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/exception.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../routes/navigation_services.dart';
import '../../widgets/app_toaster.dart';
import '../../widgets/custom_loading.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController reNewPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    reNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    reNewPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Đổi mật khẩu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
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
                    PasswordFormField(
                      title: "Mật khẩu hiện tại",
                      hint: "Nhập mật khẩu hiện tại",
                      controller: currentPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bạn cần điền đầy đủ thông tin";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24,),
                    PasswordFormField(
                      title: "Mật khẩu mới",
                      hint: "Nhập mật khẩu mới",
                      controller: newPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bạn cần điền đầy đủ thông tin";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24,),
                    PasswordFormField(
                      title: "Xác nhận mật khẩu mới",
                      hint: "Nhập lại mật khẩu mới",
                      controller: reNewPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bạn cần điền đầy đủ thông tin";
                        } else if (value != newPasswordController.text.trim()) {
                          return "Bạn cần điền mật khẩu giống nhau";
                        }
                        return null;
                      },
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
                    if (_formKey.currentState!.validate()) {
                      final auth = context.read<AuthViewModel>();
                      final currentPassword = currentPasswordController.text.trim();
                      final newPassword = newPasswordController.text.trim();

                      showAppLoading(context);
                      try {
                        final data = {
                          "currentPassword": currentPassword,
                          "newPassword": newPassword,
                        };
                        await context.read<UserViewModel>().changePassword(auth.currentUser!.id, data, auth.token!);
                        NavigationService().pop();
                        // ignore: use_build_context_synchronously
                        AppToaster.showToast(
                          context: context,
                          msg: "Đổi mật khẩu thành công",
                          type: AppToasterType.success,
                        );
                        NavigationService().pop();
                      } catch (e) {
                        if (e is IncorrectCurrentPasswordException) {
                          NavigationService().pop();
                          AppToaster.showToast(
                            context: context,
                            msg: "Mật khẩu hiện tại không chính xác",
                            type: AppToasterType.failed,
                          );
                        } else {
                          NavigationService().pop();
                          AppToaster.showToast(
                            context: context,
                            msg: "Đổi mật khẩu không thành công",
                            type: AppToasterType.failed,
                          );
                        }
                      }
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
      ),
    );
  }
}

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.validator,
  });
  final String title;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppColors.greyTitle,
          ),
        ),
        const SizedBox(height: 6,),
        TextFormField(
          obscureText: !isShow,
          autocorrect: false,
          enableSuggestions: false,
          style: const TextStyle(fontSize: 16),
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isShow = !isShow;
                });
              },
              child: Icon(
                isShow ? Icons.visibility : Icons.visibility_off,
                color: AppColors.greyText,
              ),
            ),
            hintText: widget.hint,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9))
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9))
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}