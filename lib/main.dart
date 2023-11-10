import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/splashscreen.dart';
import 'firebase_options.dart';

void main() async
{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/splashscreen',
    routes:
    {
      '/splashscreen' : (context) => SplashScreen(),

    },
  ));
}