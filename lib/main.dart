import 'package:flutter/material.dart';
import 'package:tatudu/db_helper/db_helper.dart';
import 'package:tatudu/utils/colors.dart';

import 'home/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:tatudu/home/services/home_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: AppColor.primarySwatch,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
