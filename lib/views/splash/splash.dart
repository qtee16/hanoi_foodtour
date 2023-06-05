import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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
    checkLogined().then((value) {
      if (value) {
        context.read<AuthViewModel>().fetchCurrentUser().then(
            (value) => NavigationService().pushNameAndRemoveUntil(ROUTER_HOME));
      } else {
        NavigationService().pushNameAndRemoveUntil(ROUTER_HOME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Splash")),
    );
  }
}
