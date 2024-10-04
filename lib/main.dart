import 'package:cabswalle/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes status bar transparent
      statusBarIconBrightness: Brightness.dark, // Sets text and icons to black
    ),
  );
  runApp(const MyApp());
}
