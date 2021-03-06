import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/constants.dart';

import 'package:social_media_app/providers/api.dart';

import 'package:fluttertoast/fluttertoast.dart';

enum PostType {
  ImagePost,
  TextPost,
}

class AddPost extends StatefulWidget {
  // const AddPost({Key key}) : super(key: key);
  final BuildContext context;

  AddPost(this.context);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  PostType postType;
  TextEditingController titleController;
  TextEditingController textPostController;
  XFile chosenImage;
  dynamic chosenCommunity;
  bool isPosting = false;

  void setImage(XFile image) {
    chosenImage = image;
  }

  Future<void> postPost() async {
    print(titleController.value.text);
    print(postType);
    print(textPostController.value.text);

    if (postType == PostType.TextPost) {
      if (titleController.value.text.trim().isEmpty) {
        Fluttertoast.showToast(msg: 'Title cannot be empty');
        return;
      }

      if (textPostController.value.text.trim().isEmpty) {
        Fluttertoast.showToast(msg: 'Text Post cannot be empty');
        return;
      }

      setState(() {
        isPosting = true;
      });

      chosenCommunity != null
          ? await Api.postCommunityTextPost(
              id: chosenCommunity['_id'],
              title: titleController.value.text.trim(),
              text: textPostController.value.text.trim(),
            )
          : await Api.postUserTextPost(
              title: titleController.value.text.trim(),
              text: textPostController.value.text.trim(),
            );
    }

    if (postType == PostType.ImagePost) {
      if (chosenImage == null) {
        Fluttertoast.showToast(msg: 'No Image Selected');
        return;
      }

      if (titleController.value.text.trim().isEmpty) {
        Fluttertoast.showToast(msg: 'Please enter title');
        return;
      }

      setState(() {
        isPosting = true;
      });
      chosenCommunity != null
          ? await Api.postCommunityImagePost(
              id: chosenCommunity['_id'],
              title: titleController.value.text.trim(),
              image: chosenImage,
            )
          : await Api.postUserImagePost(
              title: titleController.value.text.trim(),
              image: chosenImage,
            );
    }
    setState(() {
      isPosting = false;
    });
    Navigator.of(context).pop(true);
  }

  @override
  void initState() {
    super.initState();
    postType = PostType.TextPost;
    titleController = TextEditingController();
    textPostController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    textPostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Text(
                  'New Post',
                  style: kTitleTextStyle,
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        chosenCommunity = await showSearch(
                          context: context,
                          delegate: CustomCommunitySearchDelegate(),
                        );
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          Text(
                            chosenCommunity == null
                                ? 'Choose a community'
                                : '${chosenCommunity['name']}',
                            style: kSubtitleTextStyle,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                            size: 40,
                          ),
                        ],
                      ),
                      // color: Colors.purpleAccent,
                      style: OutlinedButton.styleFrom(
                        primary: Color.fromRGBO(225, 37, 255, 1),
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          width: 1.3,
                          color: Color.fromRGBO(225, 37, 255, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    // left: 10,
                    bottom: 10,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      size: 30,
                    ),
                    // minLeadingWidth: 0,
                    horizontalTitleGap: 0,
                    title: Text(
                      'Leave the community field empty to post to your profile',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        // height: 10.5,
                      ),
                    ),
                  )),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       labelText: 'Community Name',
              //       border: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(
              //           const Radius.circular(6),
              //         ),
              //       ),
              //       prefixIcon: Icon(Icons.search),
              //     ),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                ),
                child: Text(
                  'Post Type',
                  style: kSubtitleTextStyle.copyWith(
                      fontSize: 14, color: Color.fromRGBO(113, 106, 106, 1)),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          postType = PostType.TextPost;
                        });
                      },
                      child: CustomButton(
                        icon: Icon(
                          Icons.document_scanner_sharp,
                          color: Colors.white,
                        ),
                        label: 'Text Post',
                        selected: postType == PostType.TextPost ? true : false,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          postType = PostType.ImagePost;
                        });
                      },
                      child: CustomButton(
                        icon: Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        label: 'Image Post',
                        selected: postType == PostType.ImagePost ? true : false,
                      ),
                    ),
                  ),
                ],
              ),
              postType == PostType.TextPost
                  ? Container(
                      // padding: EdgeInsets.only(
                      //     bottom: MediaQuery.of(context).viewInsets.bottom),
                      margin: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: TextField(
                        controller: textPostController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(6),
                            ),
                          ),
                        ),
                        maxLines: 8,
                      ),
                    )
                  : ImagePickerHelper(
                      chosenImage,
                      setImage,
                      imageHeight: 0.3,
                      imageWidth: 0.8,
                    ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(69, 83, 243, 1)),
                        onPressed: () => isPosting ? null : postPost(),
                        child: Text(isPosting ? 'Posting' : 'Post'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PickImageBtn extends StatelessWidget {
  const PickImageBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 24,
          ),
        ],
      ),
      child: Text('Pick Image'),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final bool selected;

  CustomButton({this.icon, this.label, this.selected = false});

  Color isSelected() {
    return selected
        ? Color.fromRGBO(141, 38, 221, 1)
        : Color.fromRGBO(135, 135, 135, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected(),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon,
          Text(
            '$label',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}

class ImagePickerHelper extends StatefulWidget {
  XFile previousImage;
  Function setImage;
  final double imageHeight, imageWidth;

  ImagePickerHelper(
    this.previousImage,
    this.setImage, {
    this.imageHeight,
    this.imageWidth,
  });

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerHelper> {
  ImagePicker _picker;
  XFile _pickedImage;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    if (widget.previousImage != null) _pickedImage = widget.previousImage;
  }

  void _pickImage() async {
    XFile selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    var croppedFile = await ImageCropper.cropImage(
        sourcePath: selectedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    File compressedFile = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path,
      '${Directory.systemTemp.path}/${DateTime.now()}.jpg',
      quality: 60,
    );

    // XFile(result.path);

    setState(() {
      if (compressedFile != null) _pickedImage = XFile(compressedFile.path);
      widget.setImage(_pickedImage);
      compressedFile.length().then((value) => print(value));
      print(compressedFile.lengthSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    return _pickedImage == null
        ? Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
              child: InkWell(
                child: PickImageBtn(),
                onTap: _pickImage,
              ),
            ),
          )
        : Center(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height * widget.imageHeight,
                  width: MediaQuery.of(context).size.width * widget.imageWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(_pickedImage.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      onPressed: _pickImage,
                      child: Text(
                        'Select an image',
                        style: kSubtitleTextStyle,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class CustomCommunitySearchDelegate extends SearchDelegate {
  List searchResult;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(
          Icons.clear,
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: Api.getCommunitySearch(key: query),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (!snapshot.hasData)
          return Center(child: Text('Choose a community'));
        else {
          searchResult = snapshot.data;
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_, ind) => ListTile(
              title: Text(snapshot.data[ind]['name']),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data[ind]['image']),
              ),
              onTap: () => close(context, snapshot.data[ind]),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: Api.getCommunitySearch(key: query),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Center(child: Text('Choose a community'));
        searchResult = snapshot.data;
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (_, ind) => ListTile(
            title: Text(snapshot.data[ind]['name']),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data[ind]['image']),
            ),
            onTap: () => close(context, snapshot.data[ind]),
          ),
        );
      },
    );
  }
}
