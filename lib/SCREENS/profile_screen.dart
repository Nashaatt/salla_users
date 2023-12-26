import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/AUTH/login.dart';
import 'package:smart_shop/MODELS/user-model.dart';
import 'package:smart_shop/PROVIDERS/theme_provider.dart';
import 'package:smart_shop/PROVIDERS/user_provider.dart';
import 'package:smart_shop/SCREENS/InnerScreens/order/order_screen.dart';
import 'package:smart_shop/SCREENS/InnerScreens/viewed_Recent_Screen.dart';
import 'package:smart_shop/SCREENS/InnerScreens/wislist_screen.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:smart_shop/WIDGETS/subtitles.dart';
import 'package:smart_shop/WIDGETS/titles.dart';

import '../CONSTANTS/app_colors.dart';
import '../WIDGETS/AddAddressScreen.dart';
import '../WIDGETS/loading_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool isLoading = false;
  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      // ignore: use_build_context_synchronously
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: error.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: LoadingManager(
          isLoading: isLoading,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Account",
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: user == null ? true : false,
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      "LOGIN TO ACCESS UNLIMITED FEATURES",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                user == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                  color: AppColors.goldenColor,
                                  width: 3,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    userModel != null &&
                                            userModel!.userImage != null &&
                                            userModel!.userImage != ""
                                        ? userModel!.userImage.toString()
                                        : "",
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitlesTextWidget(
                                  label: userModel != null
                                      ? userModel!.userName.toString()
                                      : "",
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SubtitleTextWidget(
                                  label: userModel != null
                                      ? userModel!.userEmail.toString()
                                      : "",
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitlesTextWidget(
                        label: "General Settings",
                        fontSize: 18,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        visible: user == null ? false : true,
                        child: CustomListTitle(
                            text: "All Orders",
                            icon: const Icon(
                              Icons.shopping_basket_outlined,
                              color: AppColors.goldenColor,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, OrdersScreenFree.routeName);
                            }),
                      ),
                      Visibility(
                        visible: user == null ? false : true,
                        child: CustomListTitle(
                          text: "Wishlist",
                          icon: const Icon(
                            Icons.favorite_outline_sharp,
                            color: AppColors.goldenColor,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, WishListScreen.routName);
                          },
                        ),
                      ),
                      CustomListTitle(
                        text: "Viewed recent",
                        icon: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: AppColors.goldenColor,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, ViewedRecentScreen.routName);
                        },
                      ),
                      CustomListTitle(
                          text: "Address",
                          icon: const Icon(
                            Icons.map,
                            color: AppColors.goldenColor,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AddressEditScreen.routName);
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      const TitlesTextWidget(
                        label: "Theme Mode",
                        fontSize: 18,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        child: SwitchListTile(
                            activeColor: const Color(0xffCBB26A),
                            title: Text(
                              themeProvider.getIsDarkTheme ? "Dark" : "Light",
                              style: const TextStyle(fontSize: 15),
                            ),
                            secondary: Image.asset(
                              "IMG/theme.png",
                              height: 30,
                            ),
                            value: themeProvider.getIsDarkTheme,
                            onChanged: (value) {
                              themeProvider.setDarkTheme(themeValue: value);
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      //////////////////////SignOut//////////////////////////
                      Center(
                        child: TextButton(
                            onPressed: () async {
                              if (user == null) {
                                Navigator.pushNamed(
                                  context,
                                  LoginScreen.routName,
                                );
                              } else {
                                await FirebaseAuth.instance.signOut();
                                if (!mounted) return;
                                Navigator.pushNamed(
                                  context,
                                  LoginScreen.routName,
                                );
                              }
                            },
                            child: Text(
                              user == null ? "Sign in" : "Sign out",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldenColor,
                              ),
                            )),
                      ),

                      //??????????????????/////////////////////ELVAED BUTTON ////////??????????????????????????????
                      // Center(
                      //   child: SizedBox(
                      //     width: double.infinity,
                      //     child: ElevatedButton.icon(
                      //       onPressed: () async {
                      //         if (user == null) {
                      //           Navigator.pushNamed(
                      //             context,
                      //             LoginScreen.routName,
                      //           );
                      //         } else {
                      //           await FirebaseAuth.instance.signOut();
                      //           if (!mounted) return;
                      //           Navigator.pushNamed(
                      //             context,
                      //             LoginScreen.routName,
                      //           );
                      //         }
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         elevation: 40,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(10)),
                      //         backgroundColor: AppColors.goldenColor,
                      //       ),
                      //       icon: Icon(user == null ? Icons.login : Icons.logout),
                      //       label: Text(
                      //         user == null ? "Login" : "Logout",
                      //         style: const TextStyle(fontSize: 10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTitle extends StatelessWidget {
  CustomListTitle(
      {super.key, required this.text, required this.icon, required this.onTap});
  final String text;
  final Widget icon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13,
        ),
        hoverColor: Colors.grey,
        onTap: onTap,
        leading: icon,
        iconColor: AppColors.goldenColor,
        title: SubtitleTextWidget(
          label: text,
          fontSize: 15,
        ),
        trailing: Icon(
          Icons.arrow_forward_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
