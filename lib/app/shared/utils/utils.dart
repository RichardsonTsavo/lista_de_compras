import 'package:flutter/material.dart';

class Utils {
  static Future showPopupDialog(
      {required BuildContext context, required Widget child}) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  static void showSnackBar(
      {required BuildContext context, required String mensage}) {
    final snackBar = SnackBar(
      content: Text(mensage),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showMaterialBanner(
      {required BuildContext context, required String mensage}) {
    final materialBanner = MaterialBanner(
      content: Text(
        mensage,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      leading: const Icon(Icons.info, color: Colors.white),
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    );
    ScaffoldMessenger.of(context).showMaterialBanner(materialBanner);
    Future.delayed(const Duration(seconds: 5)).then(
        (value) => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
  }
}
