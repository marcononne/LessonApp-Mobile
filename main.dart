import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'Routes/routes.dart';
import 'Resources/color_shemes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return GetMaterialApp(
            title: 'Lesson App',
            theme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            initialRoute: Routes.homepageRoute,
            getPages: Routes.pages, //getPages passi una lista che è pages, creata nella classe Routes
        );
    }
}

