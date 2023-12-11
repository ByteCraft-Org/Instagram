import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/pages/home_page/home_page.dart';
import 'package:instagram/pages/login_signup/login/forgot_password.dart';
import 'package:instagram/pages/login_signup/signup/signup_page.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/dimensions.dart';
import 'package:instagram/utils/keys.dart';
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
  bool isLoading = false;

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
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.025),
                    CustomTextField(// * : Password Input
                      controller: _passwordController,
                      labelText: "Password",
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.025),
                    CustomButtonWithLoading(// * : Login Button
                      isLoading: isLoading,
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        performFunction(context);
                      },
                      labelText: "Log in",
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.02),
                    CustomTextButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()
                          )
                        );
                      },
                      labelText: "Forgotten Password?",
                      textColor: Colors.white,
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.27),
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

  Future<void> performFunction(context) async {
    FocusScope.of(context).unfocus();
    final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");

    if(_emailController.text.isEmpty) {
      customSnackbar(context: context, type: "Error", message: "Email address cannot be empty.");
      return ;
    } else if(!emailRegex.hasMatch(_emailController.text)) {
      customSnackbar(context: context, type: "Warning", message: "Email address is not formatted.");
      return ;
    } else if(_passwordController.text.isEmpty) {
      customSnackbar(context: context, type: "Error", message: "Password cannot be empty.",);
      return ;
    }

    setState(() => isLoading = true);

    // * : Check whether email is present or not
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: 'dummyPassword', // A dummy password just to check if the email exists
      );
      await userCredential.user?.delete();

      customSnackbar(context: context, type: "Error", message: "Email ${_emailController.text} is not registered");
      setState(() => isLoading = false);
      return ;
    } on FirebaseAuthException catch (err) {
      if (err.code != 'email-already-in-use') {
        customSnackbar(context: context, type: "Error", message: err.toString());
        setState(() => isLoading = false);
        return ;
      }
    }

    // * : Login User
    String loginResult = await AuthMethods().signInUser(
      emailAddress: _emailController.text,
      password: _passwordController.text
    );

    if(loginResult == correctKey) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } else {
      customSnackbar(context: context, type: "Error", message: loginResult);
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}