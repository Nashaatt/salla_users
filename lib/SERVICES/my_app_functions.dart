import 'package:flutter/material.dart';
import 'package:smart_shop/WIDGETS/subtitles.dart';

class MyAppFunctions {
  static Future<void> showErrorOrWarningDialog({
    required BuildContext context,
    required String subtitle,
    bool isError = true,
    required Function fct,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  isError ? "IMG/error.png" : "IMG/warning.png",
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SubtitleTextWidget(
                  label: subtitle,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !isError,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const SubtitleTextWidget(
                          label: "Cancel",
                          color: Colors.green,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        fct();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(12),
                        decoration:
                            const BoxDecoration(color: Colors.redAccent),
                        child: const Center(
                          child: SubtitleTextWidget(
                            label: "cancel",
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            elevation: 40,
            title: const Center(
              child: Text(
                "Choose Option",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w100,
                    color: Colors.white),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(children: [
                TextButton.icon(
                  onPressed: () {
                    cameraFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.camera,
                      size: 20,
                    ),
                  ),
                  label: const SubtitleTextWidget(
                    label: "Camera",
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    galleryFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.image,
                      size: 20,
                    ),
                  ),
                  label: const SubtitleTextWidget(
                    label: "Gallery",
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    removeFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                    ),
                  ),
                  label: const SubtitleTextWidget(
                    label: "Remove",
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
