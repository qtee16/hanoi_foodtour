import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _startAnim = false;

  Future<bool> checkLogined() async {
    final refs = await SharedPreferences.getInstance();
    if (refs.containsKey("user_data")) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    opacityAnim();
    checkLogined().then((value) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (value) {
        // ignore: use_build_context_synchronously
        final authViewModel = context.read<AuthViewModel>();
        await authViewModel.fetchCurrentUser();
        if (authViewModel.currentUser != null) {
          final userId = authViewModel.currentUser!.id;
          final token = authViewModel.token;
          // ignore: use_build_context_synchronously
          await context.read<UserViewModel>().getMyLikes(userId, "restaurant", token!);
          // ignore: use_build_context_synchronously
          await context.read<UserViewModel>().getMyLikes(userId, "food", token);
        }
        NavigationService().pushNameAndRemoveUntil(ROUTE_HOME);
      } else {
        NavigationService().pushNameAndRemoveUntil(ROUTE_HOME);
      }
    });
  }

  void opacityAnim() async {
    Future.delayed(const Duration(milliseconds: 300),).then((_) {
      setState(() {
        _startAnim = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background_light.png"
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _startAnim ? 1.0 : 0.0,
            child: Image.asset("assets/images/logo.png", width: 200, fit: BoxFit.cover,),
          ),
        ),
      ),
    );
  }
}
