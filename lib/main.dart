import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanoi_foodtour/injection.dart';
import 'package:hanoi_foodtour/repositories/general_repo.dart';
import 'package:hanoi_foodtour/view_models/auth_view_model.dart';
import 'package:hanoi_foodtour/view_models/restaurant_view_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'routes/navigation_services.dart';
import 'routes/root_router.dart';
import 'views/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = NavigationService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(
            generalRepo: getIt<GeneralRepo>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantViewModel(
            generalRepo: getIt<GeneralRepo>(),
          ),
        ),
      ],
      child: OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.light().copyWith(
              useMaterial3: true, textTheme: GoogleFonts.montserratTextTheme()),
          navigatorKey: navigationService.navigationKey,
          onGenerateRoute: generateRoute,
          home: const Splash(),
        ),
      ),
    );
  }
}
