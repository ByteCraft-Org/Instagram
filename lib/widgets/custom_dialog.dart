import 'package:flutter/material.dart';

import '../utils/colors.dart';

customDialog({
    required BuildContext context,
    required bool barrierDismissble,
    required IconData icon,
    required Color iconColor,
    required Color headingColor,
    required String heading,
    required String message,
    required String buttontext,
    required Function onTap
  }
) {
  return showDialog(
    barrierDismissible: barrierDismissble,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.grey.shade900,
        insetPadding: const EdgeInsets.all(75),
        insetAnimationCurve: Curves.ease,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                alignment: Alignment.center,
                child: Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: headingColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(
                    icon,
                    size: 40,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                child: GestureDetector(
                  onTap: () => onTap(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      buttontext,
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      );
    },
  );
}
