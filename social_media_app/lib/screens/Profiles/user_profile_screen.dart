import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/myself.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/screens/ProfileInfoScreen/profile_info_arguments.dart';
import 'package:social_media_app/screens/ProfileInfoScreen/profile_info_screen.dart';
import 'package:social_media_app/screens/Registration/step1.dart';
import 'package:social_media_app/screens/Registration/step2.dart';
import 'package:social_media_app/screens/Registration/step3.dart';
import 'package:social_media_app/widgets/appBars.dart';
import 'package:social_media_app/widgets/post_item.dart';
import 'package:social_media_app/widgets/profile_events.dart';
import 'package:social_media_app/widgets/profile_header.dart';

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
  Future posts;
  User user;
  bool isMe;

  @override
  void initState() {
    super.initState();
    widget.userId == null
        ? future = Api.getUser()
        : future = Api.getUserWithId(widget.userId);
    Global.setStatusBarColor();

    // posts = ;
    // Api.getsnapshot().then((value) => snapshot = value);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    posts = widget.userId == null
        ? Api.getUserPosts(
            Provider.of<Myself>(context, listen: false).myself.uid)
        : Api.getUserPosts(widget.userId);
    // user = Provider.of<User>(context);
  }

  Future refresh() async {
    setState(() {
      posts = widget.userId == null
          ? Api.getUserPosts(
                  Provider.of<Myself>(context, listen: false).myself.uid)
              .then((value) => value)
          : Api.getUserPosts(widget.userId).then((value) => value);
    });
    // return posts = null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        resizeToAvoidBottomInset: true,
        appBar: transparentAppBar(),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildProfileUI(),
                buildProfilePosts(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileUI() => FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (Provider.of<Myself>(context, listen: false).myself == null)
              return SpinKitChasingDots(
                color: kPrimaryColor,
              );

            user = snapshot.data;
            isMe =
                user.uid.compareTo(Provider.of<Myself>(context).myself.uid) ==
                    0;
            print(user.uid + ' ' + Provider.of<Myself>(context).myself.uid);

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
                            FaIcon(
                              FontAwesomeIcons.solidUser,
                              color: Colors.blue,
                              size: 18,
                            ),
                            SizedBox(width: 5),
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
                          FaIcon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.red,
                            size: 18,
                          ),
                          SizedBox(width: 5),
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
                            FaIcon(
                              FontAwesomeIcons.userFriends,
                              color: Colors.purpleAccent,
                              size: 18,
                            ),
                            SizedBox(width: 5),
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
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                Future.delayed(Duration(milliseconds: 1000),
                                    (() async {
                                  print('pushing registration');
                                  String name = user.name,
                                      userName = user.userName,
                                      email = user.email,
                                      bio = user.bio,
                                      firebaseUid;
                                  XFile image;
                                  List<String> skills;

                                  var userData = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => Step1(
                                                username: userName,
                                                name: name,
                                                onPrimaryButtonPressed: () {},
                                                email: email,
                                              )));
                                  if (userData == null) {
                                    return Navigator.pop(context);
                                  }
                                  name = userData['name'];
                                  userName = userData['username'];
                                  email = userData['email'];

                                  var imageData = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => Step2(
                                                currentImage: user.image,
                                              )));

                                  if (imageData == null) {
                                    return Navigator.pop(context);
                                  }

                                  image = imageData['image'];

                                  var bioData = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => Step3(
                                                bioValue: bio,
                                                skills: User.getSkillsId(
                                                    user.skills),
                                              )));
                                  if (bioData == null) {
                                    return Navigator.pop(context);
                                  }
                                  ;

                                  bio = bioData['bio'];
                                  skills = bioData['skills'];

                                  User newUser = User(
                                      name: name,
                                      email: email,
                                      userName: userName,
                                      bio: bio,
                                      uid: user.uid,
                                      skills: User.getSkillsFromIds(skills));
                                  var status;

                                  if (image == null) {
                                    print('image is null');
                                    newUser.image = user.image;
                                    status =
                                        await Api.putUserWithoutImage(newUser);
                                  } else {
                                    print('image is not null');
                                    status = await Api.putUser(newUser, image);
                                    if (status['status']) {
                                      print('new user name = ' +
                                          status['user'].name);
                                      newUser.image = status['user'].image;
                                    } else
                                      newUser.image = user.image;
                                  }

                                  if (!status['status']) {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Oops! user could not be created. Please try again');
                                    return Navigator.pop(context);
                                  }
                                  if (status['status']) {
                                    print('success');
                                    Provider.of<Myself>(context, listen: false)
                                        .setMyself(newUser);
                                    //TODO: if user does not select image, show default dp
                                    Fluttertoast.showToast(
                                        msg: 'Yay! Profile has been modified');
                                    Navigator.pop(context);
                                    return Navigator.pop(context);
                                  } else {
                                    //TODO: SHow error
                                  }
                                }));
                                return SpinKitChasingDots(
                                  color: kPrimaryColor,
                                );

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
                            onPressed: () {
                              Fluttertoast.showToast(msg: 'Coming soon!');
                            },
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
                  // ignore: null_aware_before_operator
                  if (user.skills?.length > 0 ?? 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ProfileEvents(skills: user.skills),
                    ),
                ],
              ),
            );
          }
        },
      );
  // Widget buildProfilePosts() => PostItem();

  Widget buildProfilePosts() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
              future: posts,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                else if (snapshot.hasData) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (_, ind) => ChangeNotifierProvider.value(
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
              }),
        ],
      );

  @override
  bool get wantKeepAlive => false;
}
