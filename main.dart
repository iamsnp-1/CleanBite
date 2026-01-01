import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'screens/splash_intro_screen.dart';
import 'theme/app_colors.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hygiene Vendor',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.appBackground,
            primaryColor: AppColors.primaryGreen,
            fontFamily: 'Roboto',
),

        
      home: const SplashIntroScreen(),
      
      ),
    );
  }
}
