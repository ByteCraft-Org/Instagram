import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/pages/login_signup/signup/signup_page.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/dimensions.dart';
import 'package:instagram/widgets/custom_button.dart';
import 'package:instagram/widgets/custom_snackbar.dart';
import 'package:instagram/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizedBox instagramLogo = SizedBox(// * : Instagram Logo
      height: 50,
      width: double.infinity,
      child: SvgPicture.asset(
        "assets/images/ic_instagram.svg",
        colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
        alignment: Alignment.center,
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: blueColor.withOpacity(0.15),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: getScreenHeight(context) * 0.15),
                    instagramLogo,
                    SizedBox(height: getScreenHeight(context) * 0.1),
                    CustomTextField(// * : Email Input
                      controller: _emailController,
                      labelText: "Email address",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.025),
                    CustomTextField(// * : Password Input
                      controller: _passwordController,
                      labelText: "Password",
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.025),
                    CustomButton(// * : Login Button
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        doSignIn(context);
                      },
                      labelText: "Log in",
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.29),
                    CustomButton(// * : Create New Account Button
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage()
                          )
                        );
                      },
                      labelText: "Create a new account",
                      borderColor: blueColor,
                      buttonColor: Colors.transparent,
                      textColor: blueColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  Future<void> doSignIn(context) async {
    customSnackbar(context: context, type: "Success", message: "Logined Successfully");
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}