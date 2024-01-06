import 'package:country_flags/country_flags.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/AUTH/login.dart';
import 'package:smart_shop/MODELS/user-model.dart';
import 'package:smart_shop/PROVIDERS/theme_provider.dart';
import 'package:smart_shop/PROVIDERS/user_provider.dart';
import 'package:smart_shop/SIDE%20SCREENS/order_screen.dart';
import 'package:smart_shop/SIDE%20SCREENS/viewed_Recent_Screen.dart';
import 'package:smart_shop/SIDE%20SCREENS/wislist_screen.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../CONSTANTS/app_colors.dart';
import '../SIDE SCREENS/AddAddressScreen.dart';
import '../WIDGETS/circular_widget.dart';

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
      print(error.toString());
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
        backgroundColor: const Color.fromARGB(255, 16, 60, 16),
        body: LoadingManager(
          isLoading: isLoading,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const TitlesTextWidget(
                  label: "Account",
                  fontSize: 13,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                ),

                Visibility(
                  visible: user == null ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.goldenColor,
                            elevation: 10),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const LoginScreen()))),
                        child: const Text(
                          "LOGIN TO ACCESS ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                user == null
                    ? const SizedBox.shrink()
                    //////////////////////////////  Row Information  ////////////////////////////////////////
                    : Container(
                        padding: const EdgeInsets.only(bottom: 50),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 16, 60, 16),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).hoverColor,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    userModel != null &&
                                            userModel!.userImage != null &&
                                            userModel!.userImage != ""
                                        ? userModel!.userImage.toString()
                                        : "https://media.raritysniper.com/hape-prime/4280-600.webp?cacheId=2",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                TitlesTextWidget(
                                  label: userModel != null
                                      ? userModel!.userName.toString()
                                      : "userId234948883",
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SubtitleTextWidget(
                                      label: userModel != null
                                          ? userModel!.userEmail.toString()
                                          : "userId234@salla.com",
                                      color: Colors.white60,
                                      fontSize: 15,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const Icon(
                                      Icons.verified,
                                      size: 14,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                ////////////////////////////////////   USER Sttings   ////////////////////////////////////////
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.fromBorderSide(BorderSide(
                      color: Colors.grey.shade400,
                    )),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        const CustomizeText(text: "My Account"),
                        const SizedBox(
                          height: 8,
                        ),
                        Visibility(
                          visible: user == null ? false : true,
                          child: CustomListTitle(
                              text: "My Orders",
                              icon: const Icon(
                                Ionicons.apps,
                                color: AppColors.blueColor,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, OrdersScreenFree.routeName);
                              }),
                        ),
                        Visibility(
                          visible: user == null ? false : true,
                          child: CustomListTitle(
                            text: "WishList",
                            icon: const Icon(
                              IconlyBold.heart,
                              color: AppColors.blueColor,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                WishListScreen.routName,
                              );
                            },
                          ),
                        ),
                        CustomListTitle(
                          text: "Viewed Recent",
                          icon: const Icon(
                            Ionicons.eye_off,
                            color: AppColors.blueColor,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, ViewedRecentScreen.routName);
                          },
                        ),
                        CustomListTitle(
                            text: "Address",
                            icon: const Icon(
                              Ionicons.location,
                              color: AppColors.blueColor,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AddressEditScreen.routName);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        //////////////////////////////////////////// Theme Mode ///////////////////////////////////////////////////////////////////////////
                        const CustomizeText(text: "Theme Mode"),
                        const SizedBox(
                          height: 8,
                        ),
                        /////////////////////////////////////////// Theme Mode ////////////////////////////////////////////////////////////////
                        Card(
                          margin: const EdgeInsets.only(bottom: 3),
                          child: SwitchListTile(
                              activeColor: AppColors.blueColor,
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
                          height: 10,
                        ),
                        ///////////////////////////////////////   General Settings   ////////////////////////////////////////////////
                        const CustomizeText(text: "General Settings"),
                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        const SizedBox(
                          height: 10,
                        ),
                        SettingsListTitle(
                          leading: const Icon(CupertinoIcons.globe),
                          text: "Country",
                          trailing: CountryFlag.fromCountryCode(
                            "ae",
                            height: 25,
                            width: 25,
                          ),
                          onTap: () {},
                        ),

                        SettingsListTitle(
                          leading: const Icon(CupertinoIcons.flag_circle),
                          text: "Language",
                          trailing: const TitlesTextWidget(
                            label: "English",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          onTap: () {},
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        ///////////////////////////////////////  Reach Out To us   ////////////////////////////////////////////////
                        const CustomizeText(text: "Reach Out To Us"),
                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        const SizedBox(
                          height: 10,
                        ),

                        CustomListTitle(
                          text: "Help",
                          icon: const Icon(
                            Icons.help_outline,
                            color: AppColors.blueColor,
                          ),
                          onTap: () {},
                        ),

                        CustomListTitle(
                            text: "+971-50-5344683",
                            icon: const Icon(
                              Icons.phone_callback,
                              color: AppColors.blueColor,
                            ),
                            onTap: () async {
                              final Uri url =
                                  Uri(scheme: "tel", path: "+971 505344683");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                print("Cannot connect to phone number");
                              }
                            }),

                        const SizedBox(
                          height: 10,
                        ),

                        //////////////////////        SignOut          //////////////////////////
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.settings_power,
                              color: AppColors.goldenColor,
                            ),
                            TextButton(
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
                                  user == null ? "Sign in" : "Sign Out",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.goldenColor,
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ///////////////////////////////////  Information Terms / Terms of sale / Privacy Policy //////////////////////////////////////
                        const Column(
                          children: [
                            Center(
                              child: SizedBox(
                                width: 170,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Ionicons.logo_instagram,
                                      color: Color(0xffC13584),
                                    ),
                                    Icon(
                                      Ionicons.logo_facebook,
                                      color: Color(0xff4267B2),
                                    ),
                                    Icon(
                                      Ionicons.logo_apple_appstore,
                                      color: Colors.blue,
                                    ),
                                    Icon(
                                      Ionicons.logo_tiktok,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ////////////////////////////////////// Terms  ///////////////////////////////////////////////
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SubtitleTextWidget(
                                  label: "Terms of us",
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SubtitleTextWidget(
                                  label: "Terms of sale",
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SubtitleTextWidget(
                                  label: "Privacy Policy",
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.copyright,
                                  size: 12,
                                  color: Colors.redAccent,
                                ),
                                TitlesTextWidget(
                                  label: " 2023 salla.com All rights reversed.",
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
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

/////////////////////////////////////////  customize Texts //////////////////////////////////////
class CustomizeText extends StatelessWidget {
  const CustomizeText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: TitlesTextWidget(
        label: text,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}

/////////////////////////////////////////  Customize Widgets //////////////////////////////////////
class CustomListTitle extends StatelessWidget {
  CustomListTitle({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });
  final String text;
  final Widget icon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 3),
      color: Theme.of(context).cardColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        hoverColor: Colors.grey,
        onTap: onTap,
        leading: icon,
        iconColor: AppColors.blueColor,
        title: SubtitleTextWidget(
          label: text,
          fontSize: 15,
        ),
        trailing: const Icon(
          Icons.arrow_forward_sharp,
          // color: Colors.white,
        ),
      ),
    );
  }
}

class SettingsListTitle extends StatelessWidget {
  SettingsListTitle({
    super.key,
    required this.text,
    required this.onTap,
    required this.leading,
    required this.trailing,
  });
  final String text;
  final Widget leading;
  final Widget trailing;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 3),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        hoverColor: Colors.grey,
        onTap: onTap,
        leading: leading,
        iconColor: AppColors.blueColor,
        title: SubtitleTextWidget(
          label: text,
          fontSize: 15,
        ),
        trailing: trailing,
      ),
    );
  }
}
