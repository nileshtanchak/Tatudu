import 'package:flutter/material.dart';
import 'package:tatudu/db_helper/db_helper.dart';
import 'package:tatudu/sub_task/services/sub_tudu_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SubTuduProvider()),
      ],
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
