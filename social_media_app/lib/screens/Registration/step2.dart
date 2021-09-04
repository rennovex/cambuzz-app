import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/screens/Registration/registration_screen.dart';
import 'package:social_media_app/widgets/Registration/image_selection_buttons.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';

class Step2 extends StatefulWidget {
  Function onPrimaryButtonPressed;
  Function onBackButonPressed;
  Function onSelectImageButtonPressed;
  Function onRemoveImageButtonPressed;
  String currentImage;

  Step2(
      {this.onRemoveImageButtonPressed,
      this.onSelectImageButtonPressed,
      this.onPrimaryButtonPressed,
      this.currentImage,
      this.onBackButonPressed});

  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  XFile image;
  ImagePicker picker;

  @override
  void initState() {
    picker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationScreen(
      screenMetaData: RegistrationStepTop(
        header: "Let’s add your profile image!",
        step: 2,
      ),
      screenForm: Container(
          child: Column(children: [
        SizedBox(
          height: 30,
        ),
        CircleAvatar(
          radius: 100,
          backgroundImage: (image != null)
              ? FileImage(File(image.path))
              : (widget.currentImage != null && widget.currentImage != '')
                  ? NetworkImage(widget.currentImage)
                  : AssetImage('images/no_profile_image.png'),
        ),
        SizedBox(height: 30),
        Container(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SelectImageButton(onSelectImageButtonPressed: () async {
                widget.onSelectImageButtonPressed != null
                    ? widget.onSelectImageButtonPressed()
                    : '';
                XFile selectedImage =
                    await picker.pickImage(source: ImageSource.gallery);
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
                File compressedFile =
                    await FlutterImageCompress.compressAndGetFile(
                  croppedFile.path,
                  '${Directory.systemTemp.path}/${DateTime.now()}.jpg',
                  quality: 30,
                );

                // XFile(result.path);

                setState(() {
                  if (compressedFile != null)
                    image = XFile(compressedFile.path);
                  selectedImage.length().then((value) => print(value));
                  print(compressedFile.lengthSync());
                });
              }),
              RemoveImageButton(onRemoveImageButtonPressed: () async {
                widget.onRemoveImageButtonPressed != null
                    ? widget.onRemoveImageButtonPressed()
                    : '';
                setState(() {
                  image = null;
                  widget.currentImage = null;
                });
              })
            ],
          ),
        )
      ])),
      primaryActionButtonText: "Let's set your bio >",
      primaryButtonOnPressed: () {
        widget.onBackButonPressed != null
            ? widget.onPrimaryButtonPressed()
            : '';
        Navigator.pop(context, {'image': image});
      },
      topElementStackBottomPositioning: 50,
    );
  }
}
