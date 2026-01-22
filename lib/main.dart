import 'package:flutter/material.dart';
import 'package:game_workspace/common/app_router.dart';
import 'package:game_workspace/providers/bird_fluffy_provider.dart';
import 'package:game_workspace/providers/dress_up_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BirdFluffyProvider()),
        ChangeNotifierProvider(create: (_) => DressUpProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
      ),
    );
  }
}
