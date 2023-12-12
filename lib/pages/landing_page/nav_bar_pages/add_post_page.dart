import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/custom_button.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 30
            ),
          ),
          title: const Text(
            "New post",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CustomTextButton(
                onTap: () => {}, // TODO
                labelText: "Next",
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              'Add Post',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}