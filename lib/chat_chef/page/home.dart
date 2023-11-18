import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/chat_chef/constants/palette.dart';
import 'package:flutter_study/chat_chef/constants/form_type.dart';
import 'package:flutter_study/chat_chef/page/chat.dart';
import 'package:flutter_study/chat_chef/widget/home_form_field.dart';
import 'package:logger/logger.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;

  late HomeFormField username;
  late HomeFormField email;
  late HomeFormField password;

  bool isSignupScreen = true;
  var signupHeight = 30.0;
  int animationDuration = 200;

  final _formKey = GlobalKey<FormState>();

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: animationDuration),
              curve: Curves.easeIn,
              // top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('image/red.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 90,
                    left: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Welcome',
                          style: const TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  isSignupScreen ? ' to Yummy chat!' : ' back',
                              style: const TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${isSignupScreen ? 'Signup' : 'Signin'} to Continue',
                        style: const TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(microseconds: animationDuration),
              curve: Curves.easeIn,
              top: 180,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                height: 280.0 - (isSignupScreen ? 0 : signupHeight),
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen
                                          ? Palette.textColor1
                                          : Palette.activeColor),
                                ),
                                if (!isSignupScreen)
                                  Container(
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Signup',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen
                                          ? Palette.activeColor
                                          : Palette.textColor1),
                                ),
                                if (isSignupScreen)
                                  Container(
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              username = HomeFormField(
                                  type: FormType.username,
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please enter at least 4 Characters';
                                    }
                                    return null;
                                  },
                                  keyVal: isSignupScreen ? 1 : 2,
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Palette.iconColor,
                                  ),
                                  hint: 'User name'),
                              SizedBox(
                                height: 8,
                              ),
                              if (isSignupScreen)
                                email = HomeFormField(
                                    type: FormType.email,
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    keyVal: 3,
                                    icon: Icon(
                                      Icons.email,
                                      color: Palette.iconColor,
                                    ),
                                    hint: 'email'),
                              SizedBox(
                                height: 8,
                              ),
                              password = HomeFormField(
                                  type: FormType.password,
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return 'Password must be as lease 7 characters long.';
                                    }
                                    return null;
                                  },
                                  keyVal: isSignupScreen ? 4 : 5,
                                  icon: Icon(
                                    Icons.lock,
                                    color: Palette.iconColor,
                                  ),
                                  hint: 'password'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: animationDuration),
              curve: Curves.easeIn,
              top: 430 - (isSignupScreen ? 0 : signupHeight),
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (isSignupScreen) {
                        _tryValidation();
                        print(email.value);
                        print(password.value);
                        try {
                          final newUser = await _auth.createUserWithEmailAndPassword(
                              email: email.value,
                              password: password.value);

                          if (newUser.user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Chat();
                                },
                              ),
                            );
                          }
                        } catch (error, stacktrace) {
                          Logger().e(error, stackTrace: stacktrace);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Please Check Your Email And Password'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.orange, Colors.red],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: animationDuration),
              curve: Curves.easeIn,
              top: isSignupScreen
                  ? MediaQuery.of(context).size.height - 125
                  : MediaQuery.of(context).size.height - 165,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  const Text('or Signup With'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: const Size(155, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Palette.googleColor,
                    ),
                    icon: const Icon(
                      Icons.add,
                    ),
                    label: const Text(
                      'Google',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
