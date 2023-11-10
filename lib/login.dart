import 'package:flutter/material.dart';
import 'package:todoapp/authentication_functions.dart';
import 'package:todoapp/home.dart';
import 'package:todoapp/models.dart';
import 'package:todoapp/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/sstwo.jpeg'), fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            child: Card(
              color: Colors.transparent,
              elevation: 20,
              child: Container(
                height: 340,
                width: 300,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.white54,
                        Colors.white70,
                      ],
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                iconColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black54),
                                hintStyle: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                                icon: Icon(Icons.email),
                                border: UnderlineInputBorder(),
                                labelText: 'Enter your E-mail',
                                hintText: 'for authentication purpose only'),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                iconColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black54),
                                hintStyle: TextStyle(color: Colors.black54),
                                icon: Icon(Icons.password),
                                border: UnderlineInputBorder(),
                                labelText: 'Enter your Timely password',
                                hintText: 'hope you remember.'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              UserModel user = await AuthFunctions().loginUser(_emailController.text,
                                  _passwordController.text);
                              if (context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHome(userModel: user,)),
                                );
                              }
                            },
                            icon: const Icon(Icons.arrow_right),
                            label: const Text(
                              'Enter',
                              style: TextStyle(fontSize: 15),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor: Colors.white70,
                                foregroundColor:
                                    Colors.black // Background color
                                ),
                          ),
                          SizedBox(height: 10,),
                          ElevatedButton.icon(onPressed: () async {

                            UserModel user = await AuthFunctions().signInWithGoogle();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHome(userModel: user,)));
                          },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.black38),
                            ),
                            icon: Image(image: AssetImage('assets/google.png'),height: 20,),
                            label:const Text("Sign in with Google"),

                          ),
                          TextButton(onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()),
                            );
                          }, child: Text('New to Timely? Sign up',
                            style: TextStyle(
                              color: Colors.black54,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2,
                              decorationColor: Colors.black45
                            ),))
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
