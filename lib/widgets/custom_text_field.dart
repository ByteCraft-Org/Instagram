import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/dimensions.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;

  const CustomTextField({
    super.key, 
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: getScreenHeight(context) * 0.75,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,

        cursorColor: Colors.white,

        obscureText: labelText.contains("Password"),

        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),

        decoration: InputDecoration(
          isDense: true,
          fillColor: Colors.transparent,

          hintText: labelText,
          hintStyle: const TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
            fontWeight: FontWeight.bold
          ),

          counterText: "",

          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: blueColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),

          contentPadding: const EdgeInsets.all(15)
        ),
      )
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputAction textInputAction;

  const CustomPasswordTextField({
    super.key, 
    required this.controller,
    required this.labelText,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: getScreenHeight(context) * 0.069,
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.text,
        textInputAction: widget.textInputAction,
        maxLines: 1,

        cursorColor: Colors.white,
      
        obscureText: obscureText,

        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),
      
        decoration: InputDecoration(
          isDense: true,
          fillColor: Colors.transparent,

          hintText: widget.labelText,
          hintStyle: const TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
            fontWeight: FontWeight.bold
          ),

          counterText: "",

          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: blueColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),

          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),

          contentPadding: const EdgeInsets.all(15)
        ),
      )
    );
  }
}