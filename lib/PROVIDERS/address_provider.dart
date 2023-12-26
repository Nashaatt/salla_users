import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/MODELS/address_model.dart';
import 'package:smart_shop/MODELS/cart_model.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:uuid/uuid.dart';

class AddressProvider with ChangeNotifier {
  final Map<String, AddressModel> _address = {};

  Map<String, AddressModel> get getaddress {
    return _address;
  }

   String selectedaddresses = "";

  String get SelectedAddresses => selectedaddresses;
  AddressModel? _selectedAddress;

  AddressModel? getSelectedAddress() => _selectedAddress;

  void setSelectedAddress(AddressModel address) {
    _selectedAddress = address;
      String formattedAddress =
      'Flat: ${_selectedAddress!.flat}, Area: ${_selectedAddress!.area}, State: ${_selectedAddress!.state}, Phone Number: ${_selectedAddress!.phoneNumber}';
      print(formattedAddress);
    // _selectedAddresses.add(address);
    selectedaddresses=formattedAddress;
    notifyListeners();
  }

  // void addSelectedAddress(AddressModel address) {
  //    String formattedAddress =
  //     'Flat: ${address.flat}, Area: ${address.area}, State: ${address.state}, Phone Number: ${address.phoneNumber}';
  //   _selectedAddresses.add(address);
  //   selectedaddresses=formattedAddress;
  //   notifyListeners();
  // }

  // void removeSelectedAddress(AddressModel address) {
  //   _selectedAddresses.remove(address);
  //   selectedaddresses='';
  //   notifyListeners();
  // }
  final userstDb = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;
// Firebase
  Future<void> addToAddressFirebase({
    required String phoneNumber,
    required String flat,
    required String area,
    // required String pincode,
    required String town,
    required String state,
    // required String land,
    required BuildContext context,
  }) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: "Please login first",
        fct: () {},
      );
      return;
    }
    final uid = user.uid;
    final addressId = const Uuid().v4();
    try {
      await userstDb.doc(uid).update({
        'Address': FieldValue.arrayUnion([
          {
            'phoneNumber': phoneNumber,
            'addressId': addressId,
            'flat': flat,
            'area': area,
            // 'pin': pincode,
            'town': town,
            'state': state,
            // 'land': land
          }
        ])
      });
      await fetchAddress();
      Fluttertoast.showToast(
          msg: "Address has been added",
          backgroundColor: AppColors.goldenColor,
          textColor: Colors.white);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchAddress() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      _address.clear();
      return;
    }
    try {
      final userDoc = await userstDb.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("Address")) {
        return;
      }
      final leg = userDoc.get("Address").length;
      print(leg);
      for (int index = 0; index < leg; index++) {
        _address.putIfAbsent(
            userDoc.get("Address")[index]["addressId"],
            () => AddressModel(
                  phoneNumber: userDoc.get("Address")[index]["phoneNumber"],
                  addressId: userDoc.get("Address")[index]["addressId"],
                  flat: userDoc.get("Address")[index]["flat"],
                  area: userDoc.get("Address")[index]["area"],
                  state: userDoc.get("Address")[index]["state"],
                  // pin: userDoc.get("Address")[index]["pin"],
                  // land: userDoc.get("Address")[index]["land"],
                  town: userDoc.get("Address")[index]["town"],
                ));
      }
      print(_address);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

 
}
