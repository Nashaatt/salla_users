// ignore_for_file: use_build_context_synchronously

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_shop/root_screen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.myAuth});

  final EmailOTP myAuth;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  //////////////////////// verify OTP \\\\\\\\\\\\\\\\\\\\\
  TextEditingController otp1controller = TextEditingController();

  TextEditingController otp2controller = TextEditingController();

  TextEditingController otp3controller = TextEditingController();

  TextEditingController otp4controller = TextEditingController();
  GlobalKey formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Verification Code ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("we have Sent the Verification Code to : "),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: formkey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //////////////////////////////////////11111111111111111111111111111111111111111///////////////////////////////////////
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          controller: otp1controller,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                            hintText: "0",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                      /////////////////////////////////////////2222222222222222222222222222222222/////////////////////////////////////////////////////////////
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          controller: otp2controller,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                            hintText: "0",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                      ///////////////////////////////////////////3333333333333333333333333333333////////////////////////////////////////////////////////////////////
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          controller: otp3controller,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                            hintText: "0",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                      //////////////////////////////////////////////444444444444444444444444////////////////////////////////////////////////////
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          controller: otp4controller,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                            hintText: "0",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                      /////////////////////////////////BUTTONS\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text("Clear"),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (await widget.myAuth.verifyOTP(
                                  otp: otp1controller.text +
                                      otp2controller.text +
                                      otp3controller.text +
                                      otp4controller.text) ==
                              true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP is Verified"),
                              ),
                            );
                            Navigator.pushNamed(context, RootScreen.routeName);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP is InValid"),
                              ),
                            );
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
