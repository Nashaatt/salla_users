// ignore_for_file: use_build_context_synchronously, constant_pattern_never_matches_value_type

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_shop/AUTH/login.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:smart_shop/WIDGETS/circular_widget.dart';
import 'package:smart_shop/WIDGETS/picker_widget.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';
import 'package:smart_shop/root_screen.dart';

import '../CONSTANTS/validator.dart';

class RegisterScreen extends StatefulWidget {
  static const routName = "/RegisterScreen";
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ///////// OTP ///////////////
  TextEditingController otpController = TextEditingController();
  GlobalKey formkey = GlobalKey<FormState>();
  EmailOTP myAuth = EmailOTP();

  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _repeatPasswordController;

  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _repeatPasswordFocusNode;

  final _formkey = GlobalKey<FormState>();
  XFile? _pickedImage;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  String? userImageUrl;
  bool obscureText = true;

  /////////////////  Send Otp  //////////////////////////////////

  Future<void> sendOTP() async {
    await myAuth.setConfig(
        appEmail: "me@rohitchouhan.com",
        appName: "Email OTP",
        userEmail: _emailController.text,
        otpLength: 3,
        otpType: OTPType.digitsOnly);
    if (await myAuth.sendOTP() == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP Sent Check Your Email"),
        ),
      );
    }
  }

  /////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    // Focus Nodes
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _nameController.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _repeatPasswordController.dispose();
      // Focus Nodes
      _nameFocusNode.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _repeatPasswordFocusNode.dispose();
    }
    super.dispose();
  }

  /////////////////////  Sign In Button  \\\\\\\\\\\\\\\\\\\\\\\\

  Future<void> _registerFCT() async {
    if (_pickedImage == null) {
      MyAppFunctions()
          .globalMassage(context: context, message: "Please, Pick an Image");
      return;
    }

    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });
        /////////////////////

        await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        final User? user = auth.currentUser;
        final String uid = user!.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child("usersImage")
            .child("${_emailController.text}.jpg");
        await ref.putFile(File(_pickedImage!.path));
        userImageUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          "userId": uid,
          "userName": _nameController.text,
          "userImage": userImageUrl,
          "userEmail": _emailController.text.toLowerCase(),
          "userCart": [],
          "userWish": [],
          "Address": [],
          "createdAt": Timestamp.now(),
        });

        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const RootScreen())));
      } on FirebaseException catch (error) {
        print("Firebase Error : ${e.toString()}");
      } catch (error) {
        print(error.toString());
      } finally {
        setState(() {
          isLoading = false;
          MyAppFunctions().globalMassage(
            context: context,
            message: "Account Created Successfully",
          );
        });
      }
    }
  }

  //////////////////////////////////// Image Picker Method
  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.07,
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ignore: prefer_const_constructors
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppNameTextWidget(
                              fontSize: 23,
                              text: "Sign Up",
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            AppNameTextWidget(
                              fontSize: 12,
                              text:
                                  "welcome to Salla the best store, \n your best store",
                              fontWeight: FontWeight.normal,
                              baseColor: AppColors.goldenColor,
                              highColor: Colors.green.shade100,
                            ),
                          ],
                        ),

                        //////////////////////////////////////////////////
                        const SizedBox(
                          width: 10,
                        ),
                        //////////////////IMage Piccker /////////////////
                        SizedBox(
                          // height: size.width * 0.3,
                          // width: size.width * 0.3,
                          child: ImagePickerr(
                            pickedImage: _pickedImage,
                            function: () async {
                              await localImagePicker();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  //////////////////////////////////  ///  Form Form Form  //////////////////////////////////////////////////////////////////

                  Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          style: const TextStyle(
                            fontSize: 15,
                            decorationThickness: 0,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
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
                            hintText: 'Full Name',
                            hintStyle: const TextStyle(
                              color: AppColors.goldenColor,
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: AppColors.goldenColor,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                          validator: (value) {
                            return MyValidators.displayNamevalidator(value);
                          },
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
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
                            hintText: "Email Addresss",
                            hintStyle: const TextStyle(
                                color: AppColors.goldenColor, fontSize: 14),
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
                          height: 5.0,
                        ),
                        ////////////////////////////////////////////////////////////////////////////////////////
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          style: const TextStyle(
                            fontSize: 15,
                            decorationThickness: 0,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
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
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: AppColors.goldenColor,
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              IconlyLight.lock,
                              color: AppColors.goldenColor,
                            ),
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
                          ),
                          onFieldSubmitted: (value) async {
                            FocusScope.of(context)
                                .requestFocus(_repeatPasswordFocusNode);
                          },
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: _repeatPasswordController,
                          focusNode: _repeatPasswordFocusNode,
                          style: const TextStyle(
                            fontSize: 15,
                            decorationThickness: 0,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
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
                            hintText: "Repeat password",
                            hintStyle: const TextStyle(
                                color: AppColors.goldenColor, fontSize: 14),
                            prefixIcon: const Icon(
                              IconlyLight.lock,
                              color: AppColors.goldenColor,
                            ),
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
                          ),
                          // onFieldSubmitted: (value) async {
                          //   await _registerFCT();
                          // },
                          validator: (value) {
                            return MyValidators.repeatPasswordValidator(
                              value: value,
                              password: _passwordController.text,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        /////////////////////////////////////// Login Button \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await sendOTP().then((value) async {
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      contentPadding: const EdgeInsets.all(20),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ////////// TEXT FIELD ///////////
                                          TextFormField(
                                            controller: otpController,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              hintText:
                                                  "OTP Sent, Check Your Email",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          //////////////////  Verify OTP  ////////////////
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.goldenColor,
                                            ),
                                            onPressed: () async {
                                              if (await myAuth.verifyOTP(
                                                      otp:
                                                          otpController.text) ==
                                                  true) {
                                                /////////////  True One   /////////////////////
                                                await _registerFCT();
                                              } else {
                                                /////////////  False One   ////////////////////

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text("OTP is In-Valid"),
                                                  ),
                                                );
                                                return;
                                              }
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                TitlesTextWidget(
                                                  label: 'Verity Email',
                                                  fontSize: 18,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: AppColors.goldenColor,
                            ),
                            icon: const Icon(Icons.login_outlined),
                            label: const Text(
                              "Sign up",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account ?",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    LoginScreen.routName,
                                  );
                                },
                                child: const Text(
                                  "Log in",
                                  style: TextStyle(
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                  ),
                                )),
                          ],
                        ),
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
