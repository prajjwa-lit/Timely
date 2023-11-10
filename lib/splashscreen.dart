import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:todoapp/home.dart';
import 'package:todoapp/login.dart';
import 'package:todoapp/models.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() async {
    await Future.delayed(const Duration(seconds: 2));
    // if(context.mounted)
    // {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => const Login()));
    // }
    String? uid = await const FlutterSecureStorage().read(key: 'uid');
    if(context.mounted){
      if(uid == null){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      }
      else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHome(userModel: UserModel(name: '',uid: uid))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:DecorationImage(image: AssetImage('assets/sstwo.jpeg'),fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(80, 500, 80, 0),
            child: LinearProgressIndicator(
              backgroundColor: Colors.black54,
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
          ),
        ),

      )
    );
  }
}
