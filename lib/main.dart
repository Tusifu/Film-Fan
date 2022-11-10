import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:film_fan/core/res/color.dart';
import 'package:film_fan/core/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Film Fan',
        debugShowCheckedModeBanner: false,
        theme: AppColors.getTheme,
        initialRoute: Routes.home,
        onGenerateRoute: RouterGenerator.generateRoutes,
      );
    });
  }
}
