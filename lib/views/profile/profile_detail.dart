import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/routes/navigation_services.dart';
import 'package:hanoi_foodtour/routes/routes.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin cá nhân",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          await context.read<AuthViewModel>().signOut();
          NavigationService().pushNameAndRemoveUntil(ROUTER_HOME);
        },
        child: Text("Sign out"),
      )),
    );
  }
}