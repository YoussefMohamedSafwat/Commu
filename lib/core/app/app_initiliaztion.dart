import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInitialization {
  static Future<void> initialize() async {

      WidgetsFlutterBinding.ensureInitialized();  

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

  }
}
