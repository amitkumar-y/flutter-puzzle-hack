import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:roll_the_ball/utils/router.dart';

import 'utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  AppRouter router = AppRouter();

  @override
  void initState() {
    super.initState();
    SharedPrefUtils.volume = "100";
    SharedPrefUtils.playerLevel = "0";

    final userPrefs = SharedPrefUtils.getAllUserPrefs();
    log(jsonEncode(userPrefs));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: navigatorKey,
      onGenerateRoute: router.generateRoute,
    );
  }
}
