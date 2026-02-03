import 'package:cleanarch/core/app/app_initiliaztion.dart';
import 'package:flutter/material.dart';
import 'package:cleanarch/core/app/app_providers.dart';
import 'package:cleanarch/core/di/di_container.dart' as di;

void main() async {
  await AppInitialization.initialize();
  await di.init();
  runApp(const AppProviders());
}
