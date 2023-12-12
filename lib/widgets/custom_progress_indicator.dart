import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/global_variables.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double size;
  final String message;
  final Color loadingColor, messageColor;

  const CustomCircularProgressIndicator({
    super.key,
    required this.size,
    required this.message,
    required this.loadingColor,
    required this.messageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpinKitCircle(
          size: size,
          color: loadingColor,
        ),
        SizedBox(height: getScreenHeight(context) * 0.0002 * size),
        Text(
          message,
          style: TextStyle(
            fontSize: 15,
            color: messageColor,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}