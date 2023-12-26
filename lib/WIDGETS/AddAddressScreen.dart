// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_shop/PROVIDERS/address_provider.dart';

// import '../CONSTANTS/app_colors.dart';
// import '../CONSTANTS/validator.dart';
// import 'loading_manager.dart';
// // import 'package:flutter_iconly/flutter_iconly.dart';

// // import '../CONSTANTS/app_colors.dart';
// // import '../CONSTANTS/validator.dart';
// // import 'loading_manager.dart';

// class AddressFormScreen extends StatefulWidget {
//   const AddressFormScreen({super.key});
//   static const routName = "/AddressFormScreen";
//   @override
//   State<AddressFormScreen> createState() => _AddressFormScreenState();
// }

// class _AddressFormScreenState extends State<AddressFormScreen> {
//   late final TextEditingController _phonenumberController,
//       _flatController,
//       _areaController,
//       _pinController,
//       _townController,
//       _stateController,
//       _landMarkController;

//   late final FocusNode _phonenumberFocusNode,
//       _flatFocusNode,
//       _areaFocusNode,
//       _landMarkFocusNode,
//       _townFocusNode,
//       _stateFocusNode,
//       _pinFocusNode;

//   final _formkey = GlobalKey<FormState>();

//   bool isLoading = false;
//   final auth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     _phonenumberController = TextEditingController();
//     _flatController = TextEditingController();
//     _areaController = TextEditingController();
//     _pinController = TextEditingController();
//     _townController = TextEditingController();
//     _stateController = TextEditingController();
//     _landMarkController = TextEditingController();
//     // Focus Nodes
//     _phonenumberFocusNode = FocusNode();
//     _flatFocusNode = FocusNode();
//     _areaFocusNode = FocusNode();
//     _townFocusNode = FocusNode();
//     _stateFocusNode = FocusNode();
//     _pinFocusNode = FocusNode();
//     _landMarkFocusNode = FocusNode();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     if (mounted) {
//       _phonenumberController.dispose();
//       _flatController.dispose();
//       _areaController.dispose();
//       _pinController.dispose();
//       _townController.dispose();
//       _stateController.dispose();
//       _landMarkController.dispose();

//       // Focus Nodes
//       _phonenumberFocusNode.dispose();
//       _flatFocusNode.dispose();
//       _areaFocusNode.dispose();
//       _townFocusNode.dispose();
//       _stateFocusNode.dispose();
//       _pinFocusNode.dispose();
//       _landMarkFocusNode.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../CONSTANTS/app_colors.dart';
import '../CONSTANTS/validator.dart';
import '../PROVIDERS/address_provider.dart';
import 'loading_manager.dart';

class AddressEditScreen extends StatefulWidget {
  const AddressEditScreen({super.key});
  static const routName = "/AddressEditScreen";
  @override
  State<AddressEditScreen> createState() => _AddressEditScreenState();
}

class _AddressEditScreenState extends State<AddressEditScreen> {
  late final TextEditingController _phonenumberController,
      _flatController,
      _areaController,
      _pinController,
      _townController,
      _stateController,
      _landMarkController;

  late final FocusNode _phonenumberFocusNode,
      _flatFocusNode,
      _areaFocusNode,
      _landMarkFocusNode,
      _townFocusNode,
      _stateFocusNode,
      _pinFocusNode;

  final _formkey = GlobalKey<FormState>();

  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _phonenumberController = TextEditingController();
    _flatController = TextEditingController();
    _areaController = TextEditingController();
    // _pinController = TextEditingController();
    _townController = TextEditingController();
    _stateController = TextEditingController();
    // _landMarkController = TextEditingController();
    // Focus Nodes
    _phonenumberFocusNode = FocusNode();
    _flatFocusNode = FocusNode();
    _areaFocusNode = FocusNode();
    _townFocusNode = FocusNode();
    _stateFocusNode = FocusNode();
    // _pinFocusNode = FocusNode();
    // _landMarkFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _phonenumberController.dispose();
      _flatController.dispose();
      _areaController.dispose();
      // _pinController.dispose();
      _townController.dispose();
      _stateController.dispose();
      // _landMarkController.dispose();

      // Focus Nodes
      _phonenumberFocusNode.dispose();
      _flatFocusNode.dispose();
      _areaFocusNode.dispose();
      _townFocusNode.dispose();
      _stateFocusNode.dispose();
      // _pinFocusNode.dispose();
      // _landMarkFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 216, 216, 216),
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text(
                "New address",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: "League",
                ),
              ),
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back)),
            ),
            body: LoadingManager(
                isLoading: isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width * .9,
                              // width: 330,
                              color: Colors.red,
                              child: Image.asset(
                                "IMG/map.jpeg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          // width: 340,
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text(
                                "Area",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("AI Mushrif"),
                              trailing: Text(
                                "Change",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 5.0,
                              ),
                              TextFormField(
                                controller: _phonenumberController,
                                focusNode: _phonenumberFocusNode,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  decorationThickness: 0,
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  fillColor: Colors.black,
                                  filled: true,
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(
                                    color: AppColors.goldenColor,
                                    fontSize: 10,
                                  ),
                                  // prefixIcon: const Icon(
                                  //   Icons.person,
                                  //   color: AppColors.goldenColor,
                                  // ),
                                ),
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_phonenumberFocusNode);
                                },
                                validator: (value) {
                                  return MyValidators.phoneValidator(value);
                                },
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),

                              TextFormField(
                                controller: _flatController,
                                focusNode: _flatFocusNode,
                                style: const TextStyle(
                                  color: Colors.white,
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
                                  fillColor: Colors.black,
                                  filled: true,
                                  hintText:
                                      "Flat, House no., building, Company ",
                                  hintStyle: const TextStyle(
                                      color: AppColors.goldenColor,
                                      fontSize: 10),

                                  // prefixIcon: const Icon(
                                  //   IconlyLight.message,
                                  //   color: AppColors.goldenColor,
                                  // ),
                                ),
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_flatFocusNode);
                                },
                                // validator: (value) {
                                //   return MyValidators.emailValidator(value);
                                // },
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              // Row(
                              //   children: [
                              //     SizedBox(
                              //       width: 20,
                              //     ),
                              //     Text(
                              //       "Area",
                              //       style: TextStyle(
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.bold),
                              //     )
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 5.0,
                              // ),
                              TextFormField(
                                controller: _areaController,
                                focusNode: _areaFocusNode,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  decorationThickness: 0,
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  fillColor: Colors.black,
                                  filled: true,
                                  hintText: "Area",
                                  hintStyle: const TextStyle(
                                    color: AppColors.goldenColor,
                                    fontSize: 10,
                                  ),
                                  // prefixIcon: const Icon(
                                  //   IconlyLight.lock,
                                  //   color: AppColors.goldenColor,
                                  // ),
                                ),
                                onFieldSubmitted: (value) async {
                                  FocusScope.of(context)
                                      .requestFocus(_areaFocusNode);
                                },
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              // Row(
                              //   children: [
                              //     SizedBox(
                              //       width: 20,
                              //     ),
                              //     Text(
                              //       "PIN code",
                              //       style: TextStyle(
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.bold),
                              //     )
                              //   ],
                              // ),
                              // TextFormField(
                              //   controller: _pinController,
                              //   focusNode: _pinFocusNode,
                              //   style: const TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 15,
                              //     decorationThickness: 0,
                              //   ),
                              //   textInputAction: TextInputAction.done,
                              //   keyboardType: TextInputType.visiblePassword,
                              //   decoration: InputDecoration(
                              //     contentPadding: const EdgeInsets.all(20),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //     focusedBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //     fillColor: Colors.black,
                              //     filled: true,
                              //     hintText: "PIN code",
                              //     hintStyle: const TextStyle(
                              //         color: Colors.yellow, fontSize: 10
                              //         //     color: AppColors.goldenColor, fontSize: 10),
                              //         // prefixIcon: const Icon(
                              //         //   IconlyLight.lock,
                              //         //   color: AppColors.goldenColor,
                              //         ),
                              //   ),
                              //   onFieldSubmitted: (value) async {},
                              // ),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              // Row(
                              //   children: [
                              //     SizedBox(
                              //       width: 20,
                              //     ),
                              //     Text(
                              //       "Town",
                              //       style: TextStyle(
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.bold),
                              //     )
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 5.0,
                              // ),
                              TextFormField(
                                controller: _townController,
                                focusNode: _townFocusNode,
                                style: const TextStyle(
                                  color: Colors.white,
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
                                  fillColor: Colors.black,
                                  filled: true,
                                  hintText: 'Town',
                                  hintStyle: const TextStyle(
                                    color: AppColors.goldenColor,
                                    fontSize: 10,
                                  ),
                                  // prefixIcon: const Icon(
                                  //   Icons.person,
                                  //   color: AppColors.goldenColor,
                                  // ),
                                ),
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_phonenumberFocusNode);
                                },
                                // validator: (value) {
                                //   return MyValidators.displayNamevalidator(value);
                                // },
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              // Row(
                              //   children: [
                              //     SizedBox(
                              //       width: 20,
                              //     ),
                              //     Text(
                              //       "State",
                              //       style: TextStyle(
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.bold),
                              //     )
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 5.0,
                              // ),
                              TextFormField(
                                controller: _stateController,
                                focusNode: _stateFocusNode,
                                style: const TextStyle(
                                  color: Colors.white,
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
                                  fillColor: Colors.black,
                                  filled: true,
                                  hintText: 'State',
                                  hintStyle: const TextStyle(
                                    color: AppColors.goldenColor,
                                    fontSize: 10,
                                  ),
                                  // prefixIcon: const Icon(
                                  //   Icons.person,
                                  //   color: AppColors.goldenColor,
                                  // ),
                                ),
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_phonenumberFocusNode);
                                },
                                // validator: (value) {
                                //   return MyValidators.displayNamevalidator(value);
                                // },
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              // Row(
                              //   children: [
                              //     SizedBox(
                              //       width: 20,
                              //     ),
                              //     Text(
                              //       "Landmark",
                              //       style: TextStyle(
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.bold),
                              //     )
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 5.0,
                              // ),
                              // TextFormField(
                              //   controller: _landMarkController,
                              //   focusNode: _landMarkFocusNode,
                              //   style: const TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 15,
                              //     decorationThickness: 0,
                              //   ),
                              //   textInputAction: TextInputAction.next,
                              //   keyboardType: TextInputType.name,
                              //   decoration: InputDecoration(
                              //     contentPadding: const EdgeInsets.all(20),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //     focusedBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //     fillColor: Colors.black,
                              //     filled: true,
                              //     hintText: 'landmark',
                              //     hintStyle: const TextStyle(

                              //       color: AppColors.goldenColor,
                              //       fontSize: 10,
                              //     ),
                              //     // prefixIcon: const Icon(
                              //     //   Icons.person,
                              //     //   color: AppColors.goldenColor,
                              //     // ),
                              //   ),
                              //   onFieldSubmitted: (value) {
                              //     FocusScope.of(context)
                              //         .requestFocus(_phonenumberFocusNode);
                              //   },
                              //   // validator: (value) {
                              //   //   return MyValidators.displayNamevalidator(value);
                              //   // },
                              // ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final isValid =
                                      _formkey.currentState!.validate();
                                  FocusScope.of(context).unfocus();
                                  if (isValid) {
                                    if (_phonenumberController.text != "" &&
                                            _flatController.text != "" &&
                                            _areaController.text != "" &&
                                            // _pinController.text != "" &&
                                            _townController.text != "" &&
                                            _stateController.text != ""
                                        // &&
                                        // _landMarkController.text != ""
                                        ) {
                                      //  await  addressProvider.addUserToAddress(phoneNumber: _phonenumberController
                                      //       .text
                                      //       .toString(),
                                      //   flat: _flatController.text,
                                      //   area: _areaController.text,
                                      //   pincode: _pinController.text,
                                      //   town: _townController.text,
                                      //   state: _stateController.text,
                                      //   land: _landMarkController.text,);
                                      await addressProvider
                                          .addToAddressFirebase(
                                              phoneNumber:
                                                  _phonenumberController.text
                                                      .toString(),
                                              flat: _flatController.text,
                                              area: _areaController.text,
                                              // pincode: _pinController.text,
                                              town: _townController.text,
                                              state: _stateController.text,
                                              // land: _landMarkController.text,
                                              context: context);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please fill all field",
                                          backgroundColor:
                                              AppColors.goldenColor,
                                          textColor: Colors.white);
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 44,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.goldenColor,
                                      ),
                                      child: const Text(
                                        " Save address",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
