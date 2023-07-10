import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';
import 'package:hanoi_foodtour/exception.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

import '../../view_models/user_view_model.dart';
import '../../widgets/app_toaster.dart';
import '../../widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController emailController, passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                                  final email = emailController.text.trim();
                                  final password =
                                      passwordController.text.trim();

                                  try {
                                    showAppLoading(context);
                                    await context.read<AuthViewModel>().signIn(
                                          email: email,
                                          password: password,
                                        );
                                    // ignore: use_build_context_synchronously
                                    final auth = context.read<AuthViewModel>();
                                    NavigationService().pop();
                                    // ignore: use_build_context_synchronously
                                    context.read<UserViewModel>().getMyLikes(auth.currentUser!.id, "restaurant", auth.token!);
                                    // ignore: use_build_context_synchronously
                                    context.read<UserViewModel>().getMyLikes(auth.currentUser!.id, "food", auth.token!);
                                    NavigationService()
                                        .pushNameAndRemoveUntil(ROUTE_HOME);
                                    // ignore: use_build_context_synchronously
                                    AppToaster.showToast(
                                      context: context,
                                      msg: "Đăng nhập thành công",
                                      type: AppToasterType.success,
                                    );
                                  } catch (e) {
                                    if (e
                                        is EmailOrPasswordIncorrectException) {
                                      NavigationService().pop();
                                      AppToaster.showToast(
                                        context: context,
                                        msg:
                                            "Email hoặc mật khẩu không chính xác",
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
                                'Đăng nhập',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Bạn chưa có tài khoản?",
                                style:
                                    TextStyle(color: AppColors.subTitleColor),
                              ),
                              TextButton(
                                onPressed: () {
                                  NavigationService().pushNamed(ROUTE_SIGN_UP);
                                },
                                child: const Text(
                                  "Đăng ký ngay",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ),
                            ],
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
