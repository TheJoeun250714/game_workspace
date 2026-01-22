import 'package:flutter/material.dart';
import 'package:game_workspace/providers/game_provider.dart';
import 'package:game_workspace/screens/bird_fluffy_screen.dart';
import 'package:game_workspace/screens/main_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(
        create: (_) => GameProvider(),
        child: MaterialApp(
            home: Center(

                child: MainScreen(),
            )
          // home:GameScreen(),
        ),

      );
  }
}