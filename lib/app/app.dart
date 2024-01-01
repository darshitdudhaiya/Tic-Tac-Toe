import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/home_view.dart';
import 'package:tic_tac_toe/themes/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: MyThemes.lightColorScheme,
      ),
      darkTheme:
          ThemeData(useMaterial3: true, colorScheme: MyThemes.darkColorScheme),
      title: "Tic-Tac-Toe",
      home: const HomeView(),
    );
  }
}
