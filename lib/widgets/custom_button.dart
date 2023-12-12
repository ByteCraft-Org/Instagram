import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:instagram/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String labelText;
  final Color textColor, buttonColor, borderColor;
  final bool isDisabled;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.labelText,
    this.isDisabled = false,
    this.textColor = primaryColor,
    this.buttonColor = blueColor,
    this.borderColor = blueColor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(
            width: 1,
            color: borderColor
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            labelText,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.normal
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithLoading extends StatelessWidget {
  final Function() onTap;
  final String labelText;
  final Color textColor, buttonColor, borderColor;
  final bool isDisabled;
  final bool isLoading;

  const CustomButtonWithLoading({
    super.key,
    required this.isLoading,
    required this.onTap,
    required this.labelText,
    this.isDisabled = false,
    this.textColor = primaryColor,
    this.buttonColor = blueColor,
    this.borderColor = blueColor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled
      ? null
      : isLoading
        ? null
        : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(
            width: 1,
            color: borderColor
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: isLoading
          ? SpinKitThreeBounce(
            color: textColor,
            size: 24,
          )
          : Text(
            labelText,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.normal
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final Function() onTap;
  final String labelText;
  final Color textColor;
  final double size;
  final FontWeight fontWeight;

  const CustomTextButton({
    super.key,
    required this.onTap,
    required this.labelText,
    this.textColor = blueColor,
    this.size = 15,
    this.fontWeight = FontWeight.normal
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        labelText,
        style: TextStyle(
          color: textColor,
          fontSize: size,
          fontWeight: fontWeight
        ),
      ),
    );
  }
}