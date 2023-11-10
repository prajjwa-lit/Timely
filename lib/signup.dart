import 'package:flutter/material.dart';
import 'package:todoapp/authentication_functions.dart';
import 'package:todoapp/home.dart';
import 'package:todoapp/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                height: 330,
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
                  padding: EdgeInsets.all(15.0),
                  child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  iconColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black54),
                                  hintStyle: TextStyle(color: Colors.black54),
                                  icon: Icon(Icons.person),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Enter your username',
                                  hintText: 'What can we call you?'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter valid username";
                                } else {
                                  return null;
                                }
                              },
                            ),
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
                                  hintText: 'and remember it well!'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                await AuthFunctions().signUpUser(
                                    _emailController.text,
                                    _passwordController.text);
                                if (context.mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
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
