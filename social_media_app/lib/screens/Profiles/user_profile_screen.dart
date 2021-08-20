import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/screens/ProfileInfoScreen/profile_info_arguments.dart';
import 'package:social_media_app/screens/ProfileInfoScreen/profile_info_screen.dart';
import 'package:social_media_app/screens/Registration/registration_screen.dart';
import 'package:social_media_app/widgets/post_item.dart';
import 'package:social_media_app/widgets/profile_header.dart';

import '../post_view_screen.dart';
import 'user_settings.dart';

import '../../constants.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/userProfileScreen';
  final userId;

  UserProfileScreen({this.userId});

  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<UserProfileScreen>
    with AutomaticKeepAliveClientMixin {
  Future<User> future;
  Future<List> posts;
  User user;
  bool isMe;

  @override
  void initState() {
    super.initState();
    widget.userId == null
        ? future = Api.getUser()
        : future = Api.getUserWithId(widget.userId);
    // posts = ;
    // Api.getsnapshot().then((value) => snapshot = value);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // user = Provider.of<User>(context);
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildProfileUI(),
              buildProfilePosts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileUI() => FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            user = snapshot.data;
            isMe = user.uid == Global.myself.uid;
            print('is me' + isMe.toString());
            print(Global.myself.email);
            return ChangeNotifierProvider.value(
              value: user,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileHeader(
                    coverImg: user?.coverImage,
                    profileImg: user?.image,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${user?.name}',
                        style: kProfileName,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          '${user.bio ?? ''}',
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
                              id: user.uid, title: 'Followers'),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                            Consumer<User>(
                              builder: (_, user, __) => (Text(
                                '${user.followersCount ?? 0} Followers',
                                style: kProfileLabel,
                              )),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Text(
                            '${user?.likeCount ?? 0} Likes',
                            style: kProfileLabel,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ProfileInfoScreen.routeName,
                          arguments: ProfileInfoArguments(
                              id: user.uid, title: 'Following'),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              MdiIcons.medal,
                              color: Colors.purpleAccent,
                            ),
                            Text(
                              '${user.followingCount ?? 0} Following',
                              style: kProfileLabel,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      if (isMe)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Container();
                                //   return RegistrationScreen(true, onRegistrationComplete: (){
                                //     //completed
                                //   }, user:Global.myself);
                              }));
                            },
                            child: Text(
                              'Edit Profile',
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
                      if (!isMe)
                        Consumer<User>(
                          builder: (context, user, _) => Expanded(
                            child: Ink(
                              height: 38,
                              decoration: BoxDecoration(
                                gradient: kButtonLinearGradient,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextButton(
                                onPressed: () => user.toggleFollow(),
                                child: Text(
                                  user.isFollowing ? 'Following' : 'Follow',
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
                      if (isMe)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => showModalBottomSheet<dynamic>(
                              context: context,
                              builder: (context) => UserSettings(
                                onLogout: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            child: Text(
                              'Settings',
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
                      if (!isMe)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Send a message',
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
            );
          }
        },
      );

  Widget buildProfilePosts() => FutureBuilder(
      future: widget.userId == null
          ? Api.getUserPosts(Global.myself.uid)
          : Api.getUserPosts(widget.userId),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (snapshot.hasData) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data?.length,
            itemBuilder: (_, ind) => ChangeNotifierProvider.value(
                value: snapshot.data[ind] as Post, child: PostItem()),
          );
        } else
          return Center(
            child: Text('No posts'),
          );
      });

  @override
  bool get wantKeepAlive => false;
}
