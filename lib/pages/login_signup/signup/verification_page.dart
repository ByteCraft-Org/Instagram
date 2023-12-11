import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram/pages/landing_page/app_landing_page.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/keys.dart';
import 'package:instagram/widgets/custom_button.dart';
import 'package:instagram/widgets/custom_progress_indicator.dart';
import 'package:instagram/widgets/custom_snackbar.dart';

class VerificationPage extends StatefulWidget {
  final Uint8List selectedImage;
  final String username;
  final String email;

  const VerificationPage({
    super.key,
    required this.selectedImage,
    required this.username,
    required this.email,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;
  
  bool isVerified = false;
  bool isResendButtonEnabled = false;
  int timerSeconds = 90;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(
      const Duration(milliseconds: 1500),
      (timer) {
        checkEmailVerifed(context);
      }
    );

    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor.withOpacity(0.15),
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Icon(
                Icons.email,
                color: Colors.white,
                size: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                "Verify your email",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Before going on further please verify your email address",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.normal
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "We've sent an email to ${widget.email} to verify your email address and activate your account.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.normal
                ),
              ),
              const SizedBox(height: 20),
              !isVerified
              ? const CustomCircularProgressIndicator(
                size: 90,
                loadingColor: Colors.amber,
                message: "Verifying...",
                messageColor: Colors.white
              )
              : const Column(
                children: [
                  Icon(
                    Icons.done,
                    color: Colors.green,
                    size: 90,
                  ),
                  Text(
                    "Verification Successful",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              if(!isVerified)
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      CustomButton(
                        onTap: () => isResendButtonEnabled
                        ? resendVerification()
                        : null,
                        labelText: isResendButtonEnabled
                            ? "Resend Verification Link"
                            : "Resend link in $timerSeconds seconds",
                        borderColor: isResendButtonEnabled ? blueColor : Colors.grey,
                        buttonColor: Colors.transparent,
                        textColor: isResendButtonEnabled ? blueColor : Colors.grey,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void resendVerification() {
    user.sendEmailVerification();
    setState(() {
      isResendButtonEnabled = false;
    });
    startTimer();
  }

  void startTimer() {
    timerSeconds = 90;
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(
      oneSecond,
      (Timer timer) {
        if (timerSeconds == 0) {
          setState(() {
            isResendButtonEnabled = true;
          });
          timer.cancel();
        } else {
          setState(() {
            timerSeconds--;
          });
        }
      },
    );
  }

  Future<void> checkEmailVerifed(context) async {
    user = auth.currentUser!;
    await user.reload();

    if(user.emailVerified) {
      setState(() => isVerified = true); 
      signUp(context);
    }
  }

  Future<void> signUp(context) async {// * : SignUp User
    String signUpResult =  await AuthMethods().signUpUser(
      profileImage: widget.selectedImage,
      userName: widget.username,
      emailAddress: widget.email
    );

    if(signUpResult == correctKey) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AppLandingPage()),
        (route) => false,
      );
    } else {
      customSnackbar(context: context, type: "Error", message: signUpResult);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}