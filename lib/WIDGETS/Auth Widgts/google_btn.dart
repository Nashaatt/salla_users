import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:smart_shop/root_screen.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignSignIn({required BuildContext context}) async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();
      print(googleAccount);
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        print(googleAuth);
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          final authResults = await FirebaseAuth.instance
              .signInWithCredential(GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ));
           final User? user = FirebaseAuth.instance.currentUser;
        final String uid = user!.uid;
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
          "userId": authResults.user!.uid,
          "userName": authResults.user!.displayName,
          "userImage": authResults.user!.photoURL,
          "userEmail": authResults.user!.email,
          "userCart": [],
          "userWish": [],
          "Address":[],
          "createdAt": Timestamp.now(),
        });
        }
       
      }
      
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacementNamed(context, RootScreen.routeName);
      });
    } on FirebaseException catch (error) {
      // ignore: use_build_context_synchronously
      // await MyAppFunctions.showErrorOrWarningDialog(
      //   context: context,
      //   subtitle: error.message.toString(),
      //   fct: () {},
      // );
      print(error.message.toString());
    } catch (error) {
      // ignore: use_build_context_synchronously
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: error.toString(),
        fct: () {},
      );
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12.0),
        backgroundColor: AppColors.goldenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
      ),
      icon: const Icon(
        Ionicons.logo_google,
        color: Color.fromARGB(255, 204, 7, 7),
      ),
      label: const Text(
        "Sign in with google",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
      onPressed: () async {
        await _googleSignSignIn(context: context);
      },
    );
  }
}
