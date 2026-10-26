
import 'package:arven/core/utils/cache_helper.dart';
import 'package:arven/features/auth/presentation/screens/login_screen.dart';
import 'package:arven/features/auth/presentation/screens/register_screen.dart';
import 'package:arven/features/products/presentation/screens%5D/home_screen.dart';
import 'package:flutter/material.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
