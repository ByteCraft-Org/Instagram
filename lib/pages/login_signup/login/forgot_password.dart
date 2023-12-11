import 'package:flutter/material.dart';
import 'package:instagram/pages/login_signup/signup/signup_page.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/utils/keys.dart';
import 'package:instagram/widgets/custom_dialog.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_snackbar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: blueColor.withOpacity(0.15),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(// * : Back button
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
                SizedBox(height: getScreenHeight(context) * 0.020),
                const Text(// * : Heading Text
                  "Find your account",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: getScreenHeight(context) * 0.015),
                const Text(// * : Label Text
                  "Enter your username or email address",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.normal
                  ),
                ),
                SizedBox(height: getScreenHeight(context) * 0.025),
                CustomTextField(// * : Text Field input
                  controller: _emailController,
                  labelText: "Email address",
                  keyboardType: TextInputType.emailAddress
                ),
                SizedBox(height: getScreenHeight(context) * 0.025),
                CustomButtonWithLoading(// * : Find Account Button
                  isLoading: isLoading,
                  onTap: () => performFunction(context),
                  labelText: "Send Reset Password Link",
                ),
                Expanded(// * : Go to Sign Up Screen
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(20.0),
                    child: CustomTextButton(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,MaterialPageRoute(builder: (context) => const SignUpPage()));
                      },
                      labelText: "Didn't have an account?",
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
  
  void performFunction(context) async {
    FocusScope.of(context).unfocus();
    final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");

    if(_emailController.text.isEmpty) {
      customSnackbar(context: context, type: "Error", message: "Email address cannot be empty.");
      return ;
    } else if(!emailRegex.hasMatch(_emailController.text)) {
      customSnackbar(context: context, type: "Warning", message: "Email address is not formatted.");
      return ;
    }

    setState(() => isLoading = true);

    // * : Reset Password
    String resetPassword = await AuthMethods().resetPassword(email: _emailController.text);

    if(resetPassword != correctKey) {
      customSnackbar(context: context, type: "Error", message: resetPassword);
      return;
    } else {
      customDialog(
        context: context,
        barrierDismissble: false,
        icon: Icons.done,
        iconColor: Colors.greenAccent,
        headingColor: Colors.greenAccent,
        heading: "Link sent successfully",
        message: "We have successfully sent a reset password link to to your email ${_emailController.text}. Check your mail and change the password.",
        buttontext: "Ok",
        onTap: () {
          Navigator.pop(context);

          Future.delayed(const Duration(milliseconds: 400) , () => Navigator.pop(context));
        }
      );
    }

    setState(() => isLoading = false);
  }
}