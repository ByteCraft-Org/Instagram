import 'package:flutter/material.dart';

class AddPostPage extends StatelessWidget {

  const AddPostPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            Navigator.pop(context);
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: const Text(
            'Add Post',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}