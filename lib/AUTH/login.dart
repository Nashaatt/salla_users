import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:smart_shop/AUTH/forot_password_screen.dart';
import 'package:smart_shop/AUTH/google_btn.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:smart_shop/WIDGETS/circular_widget.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';
import 'package:smart_shop/root_screen.dart';

import '../CONSTANTS/validator.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  static const routName = "/LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loginFct() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });

        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RootScreen.routeName);
      } on FirebaseException catch (e) {
        if (e.code == 'invalid-credential') {
          MyAppFunctions()
              .globalMassage(context: context, message: "in-valid Email");
          print("ERROR Login : ${e.toString()}");
        }
      } catch (error) {
        print("ERROR Login : ${error.toString()}");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: LoadingManager(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    const AppNameTextWidget(
                      text: "Login",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TitlesTextWidget(
                        fontWeight: FontWeight.bold,
                        label: "Welcome back :)",
                        color: Color.fromARGB(255, 104, 133, 105),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            style: const TextStyle(
                              fontSize: 15,
                              decorationThickness: 0,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "example@gmail.com",
                              hintStyle: const TextStyle(
                                color: AppColors.goldenColor,
                                fontSize: 13,
                              ),
                              prefixIcon: const Icon(
                                IconlyLight.message,
                                color: AppColors.goldenColor,
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            validator: (value) {
                              return MyValidators.emailValidator(value);
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            obscureText: obscureText,
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            style: const TextStyle(
                              fontSize: 15,
                              decorationThickness: 0,
                            ),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                color: AppColors.goldenColor,
                                fontSize: 13,
                              ),
                              prefixIcon: const Icon(
                                IconlyLight.lock,
                                color: AppColors.goldenColor,
                              ),
                            ),
                            onFieldSubmitted: (value) async {
                              await _loginFct();
                            },
                            validator: (value) {
                              return MyValidators.passwordValidator(value);
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ForgotPasswordScreen.routeName);
                              },
                              child: const SubtitleTextWidget(
                                label: "Forgot password?",
                                textDecoration: TextDecoration.underline,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _loginFct();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: AppColors.goldenColor,
                              ),
                              icon: const Icon(
                                Icons.login,
                                size: 22,
                              ),
                              label: const Text(
                                "Login",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const SubtitleTextWidget(
                            label: "or",
                            fontSize: 15,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child: FittedBox(
                                    child: GoogleButton(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.person),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.goldenColor,
                                      padding: const EdgeInsets.all(12.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          11.0,
                                        ),
                                      ),
                                    ),
                                    label: const Text(
                                      " Guest  ?",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    onPressed: () async {
                                      Navigator.pushNamed(
                                        context,
                                        RootScreen.routeName,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SubtitleTextWidget(
                                label: "Already have an account ?",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              TextButton(
                                child: const SubtitleTextWidget(
                                  label: "Sign up",
                                  fontWeight: FontWeight.normal,
                                  textDecoration: TextDecoration.underline,
                                  fontSize: 13,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RegisterScreen.routName);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
