import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/exception.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../routes/routes.dart';
import '../../widgets/app_toaster.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameController,
      emailController,
      passwordController,
      rePasswordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/bg-sign.png"),
                  const SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            textCapitalization: TextCapitalization.none,
                            title: "Họ tên",
                            hint: "Nhập họ và tên của bạn",
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Bạn cần điền đầy đủ thông tin";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            textCapitalization: TextCapitalization.none,
                            title: "Email",
                            hint: "Nhập email của bạn",
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Bạn cần điền đầy đủ thông tin";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            title: "Mật khẩu",
                            hint: "Nhập mật khẩu của bạn",
                            controller: passwordController,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Bạn cần điền đầy đủ thông tin";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            title: "Xác nhận mật khẩu",
                            hint: "Xác nhận lại mật khẩu của bạn",
                            controller: rePasswordController,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Bạn cần điền đầy đủ thông tin";
                              }
                              if (value != passwordController.text.trim()) {
                                return "Bạn cần nhập mật khẩu giống nhau";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
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
                                  String name = nameController.text.trim();
                                  String email = emailController.text.trim();
                                  String password =
                                      passwordController.text.trim();

                                  try {
                                    showAppLoading(context);
                                    await context.read<AuthViewModel>().signUp(
                                          name: name,
                                          email: email,
                                          password: password,
                                        );
                                    NavigationService().pop();
                                    NavigationService()
                                        .pushNameAndRemoveUntil(ROUTE_HOME);
                                    // ignore: use_build_context_synchronously
                                    AppToaster.showToast(
                                      context: context,
                                      msg: "Đăng ký thành công",
                                      type: AppToasterType.success,
                                    );
                                  } catch (e) {
                                    print(e);
                                    if (e is EmailAlreadyInUseAuthException) {
                                      NavigationService().pop();
                                      AppToaster.showToast(
                                        context: context,
                                        msg: "Email đã được sử dụng",
                                        type: AppToasterType.failed,
                                      );
                                    } else {
                                      NavigationService().pop();
                                      AppToaster.showToast(
                                        context: context,
                                        msg: "Đã xảy ra lỗi",
                                        type: AppToasterType.failed,
                                      );
                                    }
                                  }
                                }
                              },
                              child: const Text(
                                'Đăng ký',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 64,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 32,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
