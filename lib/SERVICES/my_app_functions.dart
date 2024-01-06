import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

class MyAppFunctions {
  ////////////////////////////////App Message/////////////////////////////////
  Future<void> globalMassage(
      {required context, required String message}) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: AppColors.blueColor,
    ));
  }

  /////////////////////////////////////////////IMAGE PICKER////////////////////////////////////////////////////////////////

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 40,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ////////////////////////   Photo Library    /////////////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          galleryFCT();
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        child: const TitlesTextWidget(
                          label: "Photo Library",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(
                        Icons.my_library_add,
                        color: Colors.white,
                      ),
                    ],
                  ),

                  const Divider(
                    color: Colors.white,
                    endIndent: 0,
                    indent: 0,
                  ),

                  //////////////////////////////     Take Selfie Photo   /////////////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cameraFCT();
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        child: const TitlesTextWidget(
                          label: "Take Selfie Photo",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    endIndent: 0,
                    indent: 0,
                  ),

                  ///////////////////////////////  Delete Photo   /////////////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          removeFCT();
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        child: const TitlesTextWidget(
                          label: "Delete Photo",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(
                        CupertinoIcons.delete,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  /////////////////////////////////////////end
                ],
              ),
            ),
          );
        });
  }

  //////////////////////////////////////////////////////////////////////OTP DIALOG /////////////////////////////////////////////////////////////////
  static Future<void> showOTPDialog({
    required context,
    required controller1,
    required controller2,
    required controller3,
    required void Function()? onPressed,
  }) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //////////////////////////////////////    11111111111111111111111111111111111111111     ///////////////////////////////////////
                        SizedBox(
                          height: 60,
                          width: 54,
                          child: TextFormField(
                            controller: controller1,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              decorationColor: Colors.black,
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
                        ////////////////////////////////////////////////   222222222222222222222222222222222222    /////////////////////////////////////////////////
                        SizedBox(
                          height: 60,
                          width: 54,
                          child: TextFormField(
                            controller: controller2,
                            style: const TextStyle(
                              fontSize: 25,
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
                        ///////////////////////////////////////////   333333333333333333333333333333   /////////////////////////////////////////////////////////////
                        SizedBox(
                          height: 60,
                          width: 54,
                          child: TextFormField(
                            controller: controller3,
                            style: const TextStyle(
                              fontSize: 25,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.goldenColor),
                        onPressed: onPressed,
                        child: const Text("Submit"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
