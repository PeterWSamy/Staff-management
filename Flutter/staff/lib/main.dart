import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff/ui/home/admin_provider.dart';
import 'package:staff/ui/login/login_provider.dart';
import 'package:staff/ui/navigation/routers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Staff',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: RoutesHandler().getRouter(),
    );
  }
}
