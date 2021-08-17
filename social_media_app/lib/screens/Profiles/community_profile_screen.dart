import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/appBars/transparent_appbar.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/screens/ProfileInfoScreen/profile_info_arguments.dart';
import 'package:social_media_app/screens/ProfileInfoScreen/profile_info_screen.dart';
import 'package:social_media_app/screens/Profiles/community_settings.dart';
import 'package:social_media_app/widgets/Registration/image_selection_buttons.dart';
import 'package:social_media_app/widgets/Registration/labelled_text_field.dart';
import 'package:social_media_app/widgets/blue_primary_button.dart';
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

  ImagePicker picker;
  XFile pickedImage;

  bool communityNameAvailable = true;
  String communityName = '';

  @override
  void initState() {
    super.initState();
    future = widget.uid == null
        ? Api.getCommunity()
        : Api.getCommunityWithId(widget.uid);
    picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder(
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
                            return StatefulBuilder(
                                builder: (context, setModalState) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Create new Community',
                                              style: kTitleTextStyle,
                                            )
                                          ]),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      LabelledTextField(
                                          onChanged: (value) async {
                                            var state = await Api
                                                .isCommunityNameAvailable(
                                                    value);
                                            setModalState(() {
                                              communityName = value;
                                              communityNameAvailable = state;
                                            });
                                          },
                                          value: communityName,
                                          labelText: 'Community name'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            communityNameAvailable
                                                ? 'available'
                                                : 'taken',
                                            style: TextStyle(
                                                color: communityNameAvailable
                                                    ? Colors.green
                                                    : Colors.red),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                              radius: 70,
                                              foregroundImage: (pickedImage ==
                                                      null)
                                                  ? NetworkImage(
                                                      'https://picsum.photos/200')
                                                  : FileImage(
                                                      File(pickedImage.path))),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                SelectImageButton(
                                                    onSelectImageButtonPressed:
                                                        () async {
                                                  XFile selectedImage =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);

                                                  setModalState(() {
                                                    if (selectedImage != null)
                                                      pickedImage =
                                                          selectedImage;
                                                  });
                                                }),
                                                RemoveImageButton(
                                                    onRemoveImageButtonPressed:
                                                        () {
                                                  setModalState(() {
                                                    pickedImage = null;
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
                                        text: 'Create Community',
                                        onPressed: () async {
                                          var completed =
                                              await Api.postCommunity(
                                                  communityName, pickedImage);
                                          if (completed) {
                                            print('completee');
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          } else {
                                            print('error');
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
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
              isOwner =
                  community.owner.uid == Global?.myself.uid ? true : false;
              print(community.owner.uid + '  ' + Global?.myself.uid);
              print(isOwner);
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
                            onTap: () => Navigator.pushNamed(
                              context,
                              ProfileInfoScreen.routeName,
                              arguments: ProfileInfoArguments(
                                  id: community.uid, title: 'Members'),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.wallet_membership_outlined,
                                  color: Colors.red,
                                ),
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
                              Icon(
                                MdiIcons.medal,
                                color: Colors.purpleAccent,
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
                                onPressed: () {},
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
                                onPressed: () => showModalBottomSheet<dynamic>(
                                  context: context,
                                  builder: (context) => CommunitySettings(),
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
                                onPressed: () {},
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
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
