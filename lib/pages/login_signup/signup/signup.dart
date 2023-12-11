import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/resources/pick_image.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/dimensions.dart';
import 'package:instagram/utils/keys.dart';
import 'package:instagram/widgets/custom_button.dart';
import 'package:instagram/widgets/custom_snackbar.dart';
import 'package:instagram/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Uint8List ? _selectedImage;
  bool _isImageAdded = false;

  void _loadDefaultImage() async {
    ByteData data = await rootBundle.load('assets/images/defaultProfilePicture.jpg');
    setState(() {
      _selectedImage = data.buffer.asUint8List();
      _isImageAdded = false;
    });
  }

  void _selectImage() async {
		Uint8List ? img = await pickImage(ImageSource.gallery);
    setState(() {
      if (img != null) {
        _selectedImage = img;
        _isImageAdded = true;
      } else {
        _loadDefaultImage();
      }
    });
	}

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

    Stack profileImage = Stack(// * : Profile Image
      children: [
        _selectedImage != null
        ? CircleAvatar(radius: 72, backgroundImage: MemoryImage(_selectedImage!))
        : const CircleAvatar(radius: 72, backgroundImage: AssetImage("assets/images/defaultProfilePicture.jpg")),
        if(_isImageAdded)
          Positioned(// * : Remove Icon
            right: -5, top: -5,
            child: GestureDetector(
              onTap: () => setState(() => _loadDefaultImage()),
              child: const Icon(Icons.close, size: 30)
            ),
          ),
        Positioned(// * : Camera Icon
          right: 0, bottom: 10,
          child: GestureDetector(
            onTap: () => setState(() => _selectImage()),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: blueColor
              ),
              child: const Icon(Icons.camera_alt),
            )
          ),
        )
      ]
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: getScreenHeight(context) * 0.05),
                    instagramLogo,
                    SizedBox(height: getScreenHeight(context) * 0.05),
                    profileImage,
                    SizedBox(height: getScreenHeight(context) * 0.02),
                    CustomTextField(// * : Text Field input
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      labelText: "Username",
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.02),
                    CustomTextField(// * : Email Input
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      labelText: "Email address",
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.02),
                    CustomPasswordTextField(// * : Password Input
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      labelText: "New Password",
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.025),
                    CustomButtonWithLoading(// * : Login Button
                      isLoading: isLoading,
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        performFunction(context);
                      },
                      labelText: "Sign Up",
                    ),
                    SizedBox(height: getScreenHeight(context) * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  void performFunction(context) async {
    final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");

    if (usernameController.text.isEmpty) {
      customSnackbar(context: context, type: "Error", message: "Username cannot be empty.");
      return ;
    } else if(emailController.text.isEmpty) {
      customSnackbar(context: context, type: "Error", message: "Email address cannot be empty.");
      return ;
    } else if(!emailRegex.hasMatch(emailController.text)) {
      customSnackbar(context: context, type: "Warning", message: "Email address is not formatted.");
      return ;
    } else if(passwordController.text.isEmpty) {
      customSnackbar(context: context, type: "Error", message: "Password cannot be empty.",);
      return ;
    } else if (passwordController.text.length < 6) {
      customSnackbar(context: context, type: "Warning", message: "This password is too short.",);
      return ;
    }

    setState(() => isLoading = true);

    // * : Check whether username is available or not
    String usernameAvailability = await AuthMethods().isUserDetailPresent(
      whichCollectionKey: usersCollectionKey,
      fromWhichKey: usernameKey,
      toWhichDetail: usernameController.text
    );

    if(usernameAvailability == correctKey) {
      customSnackbar(context: context, type: "Info", message: "Username ${usernameController.text} is available");
    } else if(usernameAvailability == inCorrectKey) {
      customSnackbar(context: context, type: "Warning", message: "Username ${usernameController.text} is not available");
      setState(() => isLoading = false);
      return ;
    } else {
      customSnackbar(context: context, type: "Error", message: usernameAvailability);
      setState(() => isLoading = false);
      return ;
    }

    // * : Register User
    String registerResult = await AuthMethods().registerUser(
      email: emailController.text,
      password: passwordController.text
    );

    if(registerResult == correctKey) {
      customSnackbar(context: context, type: "Info", message: "Registered Successfully");
    } else {
      customSnackbar(context: context, type: "Warning", message: registerResult);
      setState(() => isLoading = false);
      return ;
    }

    // * : SignUp User
    String signUpResult =  await AuthMethods().signUpUser(
      profileImage: _selectedImage ?? Uint8List(0),
      userName: usernameController.text,
      emailAddress: emailController.text
    );

    if(signUpResult == correctKey) {
      customSnackbar(context: context, type: "Success", message: "Sign Up Successfully");
    } else {
      customSnackbar(context: context, type: "Error", message: signUpResult);
    }

    setState(() => isLoading = false);
  }
}