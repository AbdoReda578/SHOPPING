// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_exam/screens/login_screen.dart';
import 'providers/shop_provider.dart';

void main() => runApp(const ShopApp());

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShopProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop (Static)',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
        home:  LoginScreen(),
      ),
    );
  }
}
