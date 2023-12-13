import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/pick_image.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_variables.dart';
import 'package:instagram/widgets/custom_button.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  Uint8List ? _selectedPost;
  bool _isImageAdded = false;

  final TextEditingController _captionText = TextEditingController();
  List<String> taggedPeople = [];

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
              size: 30,
            ),
          ),
          title: const Text(
            "New post",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(// * : Display Post Image
                width: double.infinity,
                height: getScreenHeight(context) * 0.4,
                color: Color(0xFF0D0D0D),
                child: Stack(
                  children: [
                    _selectedPost != null
                    ? SizedBox(// * : Show Post
                      height: double.infinity,
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 16/9,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_selectedPost!),
                              alignment: Alignment.center
                            )
                          ),
                        ),
                      )
                    )
                    : Align(// * : Show Upload Icon
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(120),
                        child: GestureDetector(
                          onTap: () => _selectImage(),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xFF252525),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.upload,
                              size: 34,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if(_isImageAdded)
                      Positioned(// * : When image is added then show remove image icon
                        top: 0, right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () => setState(() => _removePost()),
                            child: const CircleAvatar(
                              backgroundColor: Color(0x99353535),
                              child: Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (_isImageAdded)
                Padding(// * : Write a caption
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _captionText,
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      enabled: true,
                      isDense: true,
                      labelText: "Write a caption.....",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        color: Colors.grey
                      ),
                      counterText: null,
                      border: InputBorder.none
                    ),
                  ),
                ),
              if (_isImageAdded)
                const Divider(
                  color: Color.fromRGBO(158, 158, 158, 0.5),
                ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: _isImageAdded
                      ? CustomButton(
                        onTap: () => {},
                        labelText: "Post",
                      )
                      : CustomButton(
                        onTap: () => _selectImage(),
                        labelText: "Upload Image",
                      ),
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

  void _selectImage() async {
		Uint8List ? img = await pickImage(ImageSource.gallery);
    setState(() {
      if (img != null) {
        _selectedPost = img;
        _isImageAdded = true;
      }
    });
	}

  void _removePost() {
		setState(() {
      _selectedPost = null;
      _isImageAdded = false;
    });
	}
}
