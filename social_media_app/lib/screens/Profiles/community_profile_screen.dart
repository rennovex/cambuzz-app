import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/myself.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/screens/Profiles/community_settings.dart';
import 'package:social_media_app/screens/search_screen.dart';
import 'package:social_media_app/widgets/Registration/image_selection_buttons.dart';
import 'package:social_media_app/widgets/Registration/labelled_text_field.dart';
import 'package:social_media_app/widgets/appBars.dart';
import 'package:social_media_app/widgets/blue_primary_button.dart';
import 'package:social_media_app/widgets/post_item.dart';
import 'package:social_media_app/widgets/profile_header.dart';

import '../../constants.dart';

class CommunityProfileScreen extends StatefulWidget {
  static const routeName = '/CommunityProfileScreen';
  // const CommunityProfileScreen({Key key}) : super(key: key);

  final uid;

  CommunityProfileScreen({this.uid});

  @override
  _CommunityProfileScreenState createState() => _CommunityProfileScreenState();
}

class _CommunityProfileScreenState extends State<CommunityProfileScreen> {
  Future<Community> future;
  Community community;
  bool isOwner = false;
  Future posts;

  @override
  void initState() {
    super.initState();
    future = widget.uid == null
        ? Api.getCommunity()
        : Api.getCommunityWithId(widget.uid);
    Global.setStatusBarColor();
  }

  Future refresh() async {
    setState(() {
      posts = Api.getCommunityPosts(community.uid).then((value) => value);
    });
    // return posts = null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: transparentAppBar(),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<Community> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (!snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return CreateCommunityBottomSheet();
                            });
                      },
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Create a community',
                            style: TextStyle(color: Colors.white),
                          )),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryColor)),
                    ),
                  ),
                );
              } else {
                community = snapshot.data;
                isOwner = community?.isManager || community?.isOwner;
                print(community.owner.uid +
                    '  ' +
                    Provider.of<Myself>(context).myself.uid);
                print(isOwner);

                posts = Api.getCommunityPosts(community.uid);

                return ChangeNotifierProvider.value(
                  value: community,
                  child: SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileHeader(
                          coverImg: community?.coverImage,
                          profileImg: community?.image,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${community?.name}',
                              style: kProfileName,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                '',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              // onTap: () => Navigator.pushNamed(
                              //   context,
                              //   ProfileInfoScreen.routeName,
                              //   arguments: ProfileInfoArguments(
                              //       id: community.uid, title: 'Members'),

                              child: Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.users,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5),
                                  Consumer<Community>(
                                    builder: (_, community, __) => Text(
                                      '${community.membersCount ?? 0} Members',
                                      style: kProfileLabel,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.solidCalendarCheck,
                                  color: Colors.purpleAccent,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${community.eventsCount ?? 0} Events',
                                  style: kProfileLabel,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 15),
                            if (isOwner)
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return CreateCommunityBottomSheet(
                                            communityName: community.name,
                                            currentImage: community.image,
                                            editCommunity: true,
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Edit Community',
                                    textAlign: TextAlign.center,
                                    style: kProfileButtonText,
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    primary: Color.fromRGBO(40, 102, 253, 1),
                                    backgroundColor: Colors.transparent,
                                    side: BorderSide(
                                      width: 1.3,
                                      color: Color.fromRGBO(40, 102, 253, 1),
                                    ),
                                  ),

                                  // color: Colors.purpleAccent,
                                ),
                              ),
                            if (!isOwner)
                              Consumer<Community>(
                                builder: (_, community, __) => Expanded(
                                  child: Ink(
                                    height: 38,
                                    decoration: BoxDecoration(
                                      gradient: kButtonLinearGradient,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextButton(
                                      onPressed: () => community.toggleJoin(),
                                      child: Text(
                                        community.isMember ? 'Joined' : '+Join',
                                        textAlign: TextAlign.center,
                                        style: kProfileButtonText,
                                      ),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(width: 5),
                            if (isOwner)
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () =>
                                      showModalBottomSheet<dynamic>(
                                    context: context,
                                    builder: (context) =>
                                        CommunitySettings(community),
                                  ),
                                  child: Text(
                                    'Manage',
                                    textAlign: TextAlign.center,
                                    style: kProfileButtonText,
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
                              ),
                            if (!isOwner)
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () =>
                                      showUser(context, community.owner?.uid),
                                  child: Text(
                                    'Contact Head',
                                    textAlign: TextAlign.center,
                                    style: kProfileButtonText,
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
                              ),
                            SizedBox(width: 15),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FutureBuilder(
                            future: posts,
                            builder: (_, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              else if (snapshot.hasData) {
                                return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (_, ind) =>
                                      ChangeNotifierProvider.value(
                                          value: snapshot.data[ind] as Post,
                                          child: PostItem(
                                            disableNavigation: true,
                                            refresh: refresh,
                                          )),
                                );
                              } else
                                return Center(
                                  child: Text('No posts'),
                                );
                            })
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class CreateCommunityBottomSheet extends StatefulWidget {
  String communityName;
  ImagePicker picker;
  String currentImage;
  bool editCommunity;
  CreateCommunityBottomSheet(
      {this.communityName = '',
      this.currentImage,
      this.editCommunity = false}) {
    picker = ImagePicker();
  }

  @override
  _CreateCommunityBottomSheetState createState() =>
      _CreateCommunityBottomSheetState();
}

class _CreateCommunityBottomSheetState
    extends State<CreateCommunityBottomSheet> {
  bool communityNameAvailable = true;
  bool waitingForResponse = false;
  XFile pickedImage;
  String communityName;
  @override
  void initState() {
    super.initState();
    communityName = widget.communityName;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                widget.editCommunity
                    ? 'Edit Community'
                    : 'Create new Community',
                style: kTitleTextStyle,
              )
            ]),
            SizedBox(
              height: 20,
            ),
            LabelledTextField(
                onChanged: (value) async {
                  communityName = value.toLowerCase();
                  var state = await Api.isCommunityNameAvailable(value);
                  communityNameAvailable = state;
                  setState(() {
                    print(communityName);
                  });
                },
                value: widget.communityName,
                labelText: 'Community name'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  communityNameAvailable ? 'available' : 'taken',
                  style: TextStyle(
                      color:
                          communityNameAvailable ? Colors.green : Colors.red),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  foregroundImage: (pickedImage != null)
                      ? FileImage(File(pickedImage.path))
                      : (widget.currentImage != null)
                          ? NetworkImage(widget.currentImage)
                          : AssetImage('images/no_profile_image.png'),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SelectImageButton(onSelectImageButtonPressed: () async {
                        XFile selectedImage = await widget.picker
                            .pickImage(source: ImageSource.gallery);
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
                          quality: 70,
                        );

                        // XFile(result.path);

                        setState(() {
                          if (compressedFile != null)
                            pickedImage = XFile(compressedFile.path);
                          selectedImage.length().then((value) => print(value));
                          print(compressedFile.lengthSync());
                        });
                      }),
                      RemoveImageButton(onRemoveImageButtonPressed: () {
                        setState(() {
                          pickedImage = null;
                          widget.currentImage = null;
                        });
                      })
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            BluePrimaryButton(
              isDisabled: waitingForResponse,
              text: widget.editCommunity
                  ? (waitingForResponse)
                      ? 'Modifying...'
                      : 'Modify community'
                  : (waitingForResponse)
                      ? 'Creating...'
                      : 'Create Community',
              onPressed: () async {
                if (communityName.trim().length < 3 ||
                    communityName.trim().length > 50) {
                  print('Community name = ' + communityName);
                  return Fluttertoast.showToast(
                      msg:
                          'Community name should be between 3 and 50 characters long');
                } else if (pickedImage == null && !widget.editCommunity) {
                  return Fluttertoast.showToast(
                      msg: 'Community should have an image');
                }
                var completed;
                setState(() {
                  waitingForResponse = true;
                });

                if (widget.editCommunity) {
                  if (pickedImage == null) {
                    print('picked image null');
                    completed =
                        await Api.putCommunityWithoutImage(communityName);
                  } else {
                    completed =
                        await Api.putCommunity(communityName, pickedImage);
                  }
                } else {
                  completed =
                      await Api.postCommunity(communityName, pickedImage);
                }
                if (completed) {
                  Fluttertoast.showToast(
                      msg: widget.editCommunity
                          ? 'Community modified'
                          : 'Yay! your community is up and running');
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  Fluttertoast.showToast(
                      msg:
                          'Oops! Could not ${widget.editCommunity ? 'edit' : 'create'} community');
                }
                setState(() {
                  waitingForResponse = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
