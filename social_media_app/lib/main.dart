import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/secureStorage.dart';
import 'package:social_media_app/models/skill.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/google_sign_in.dart';
import 'package:social_media_app/providers/myself.dart';
import 'package:social_media_app/screens/AddEventsScreen/add_events_screen.dart';
import 'package:social_media_app/screens/Profiles/community_profile_screen.dart';
import 'package:social_media_app/screens/Profiles/user_profile_screen.dart';
import 'package:social_media_app/screens/Registration/end.dart';
import 'package:social_media_app/screens/Registration/intro.dart';
import 'package:social_media_app/screens/Registration/step1.dart';
import 'package:social_media_app/screens/Registration/step2.dart';
import 'package:social_media_app/screens/Registration/step3.dart';
import 'package:social_media_app/screens/auth_screen.dart';
import 'package:social_media_app/screens/blocked_screen.dart';
import 'package:social_media_app/screens/event_screen.dart';
import 'package:social_media_app/screens/FeedScreen/feed_screen.dart';
import 'package:social_media_app/screens/ProfileInfoScreen/profile_info_screen.dart';
import 'package:social_media_app/screens/managers_screen.dart';
import 'package:social_media_app/screens/profile_screen.dart';
import 'package:social_media_app/screens/Registration/registration_screen.dart';
import 'package:social_media_app/screens/search_screen.dart';
import 'package:social_media_app/screens/trending_screen.dart';
import 'package:social_media_app/widgets/add_post_modal_sheet.dart';
import 'package:social_media_app/models/user.dart' as User;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging;
  messaging = FirebaseMessaging.instance;
  Global.apiToken = await SecureStorage.readApiToken() ?? '';
  Global.uid = await SecureStorage.readUid() ?? '';
  print('uid = ' + Global.uid);
  print('token = ' + Global.apiToken);
  messaging.subscribeToTopic('newEventAdded');
  messaging.subscribeToTopic('trending');
  messaging.subscribeToTopic('announcement');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GoogleSignInProvider()),
        ChangeNotifierProvider.value(value: Myself()),
        // ChangeNotifierProvider.value(value: Api()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CamBuzz',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(141, 38, 221, 1),
          backgroundColor: Color.fromRGBO(229, 229, 229, 1),

          // textTheme: TextTheme(
          //   title: TitleTextStyle,
          //   subtitle: SubtitleTextStyle,
          //   body1: BodyprimaryTextStyle,
          //   body2: BodySecondaryTextStyle,
          // )
        ),

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, firebaseSnapshot) {
            final provider = Provider.of<GoogleSignInProvider>(
              context,
            );
            if (provider.isSigningIn) {
              return buildLoading();
            } else if (firebaseSnapshot.connectionState ==
                ConnectionState.waiting) {
              return SplashScreen();
            } else if (firebaseSnapshot.hasData) {
              Global.firebaseUser = firebaseSnapshot.data;
              print('fireabse user email = ' + firebaseSnapshot.data.email);
              return FutureBuilder(
                  future: Api.isUserRegistered(firebaseSnapshot.data.email),
                  builder: (context, isRegisteredSnapshot) {
                    if (isRegisteredSnapshot.hasData) {
                      if (isRegisteredSnapshot.data) {
                        print('getting uid');
                        //if uid available go to home
                        return FutureBuilder(
                            future: Api.login(firebaseSnapshot.data.email,
                                firebaseSnapshot.data.uid),
                            builder: (context, loginSnapshot) {
                              if (loginSnapshot.hasData) {
                                if (loginSnapshot.data['status']) {
                                  print('getting user');
                                  Global.apiToken = loginSnapshot.data['token'];
                                  print('tokan = ' + Global.apiToken);
                                  return FutureBuilder(
                                      future: Api.getUser(),
                                      builder: (context, getUserSnapshot) {
                                        if (getUserSnapshot.hasData) {
                                          print('returning my home page');
                                          Provider.of<Myself>(context,
                                                  listen: false)
                                              .myself = getUserSnapshot.data;

                                          return MyHomePage();
                                        }
                                        return SplashScreen();
                                      });
                                } else {
                                  print('invalid credentials' +
                                      loginSnapshot.data['status'].toString());
                                  //TODO invalid credentials
                                }
                              }
                              return SplashScreen();
                            });
                      } else {
                        print('user is not registered');

                        print('connection done');
                        //TODO: do not render before spinkit
                        Future.delayed(Duration(milliseconds: 1000), (() async {
                          print('pushing registration');
                          String name, userName, email, bio, firebaseUid;
                          XFile image;
                          List<String> skills;
                          email = firebaseSnapshot.data.email;
                          firebaseUid = firebaseSnapshot.data.uid;
                          
                          if(!email.endsWith('@tkmce.ac.in')){
                            Provider.of<GoogleSignInProvider>(context, listen: false).logout();
                          }

                          var userData = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => Step1(
                                        onPrimaryButtonPressed: () {},
                                        email: email,
                                      )));
                          if (userData == null) return setState(() {});
                          name = userData['name'];
                          userName = userData['username'];
                          email = userData['email'];

                          var imageData = await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Step2()));

                          if (imageData == null) return setState(() {});
                          image = imageData['image'];

                          var bioData = await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Step3()));
                          if (bioData == null) return setState(() {});

                          bio = bioData['bio'];
                          skills = bioData['skills'];

                          User.User user = User.User(
                              name: name,
                              email: email,
                              userName: userName,
                              bio: bio,
                              skills: User.User.getSkillsFromIds(skills));
                          Fluttertoast.showToast(msg: 'Creating user');
                          var status =  
                              await Api.postUser(user, firebaseUid, image);

                          if (!status['status']) {
                            Fluttertoast.showToast(
                                msg:
                                    'Oops! user could not be created. Please try again');
                            setState(() {});
                          }
                          if (status['status']) {
                            print('success');
                            Global.uid = status['uid'];
                            Global.apiToken = status['token'];
                            user.uid = status['_id'];
                            print('provider setting myself');
                            Provider.of<Myself>(context, listen: false).myself =
                                user;
                            //Global.myself = user;
                            //TODO: if user does not select image, show default dp
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => End(
                                      primaryButtonOnPressed: () {
                                        Navigator.pop(context);
                                        setState(() {});
                                        //
                                        // Navigator.of(context).pushReplacement(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             MyHomePage(user)));
                                      },
                                    )));
                          } else {
                            //TODO: SHow error
                          }
                        }));

                        print('adding spinkitdots');
                        return SplashScreen();
                      }
                    }
                    return SplashScreen();
                  });
            } else {
              print('firebase login attempt');
              return Intro(
                primaryButtonOnPressed: () async {
                  var firebaseData = await provider.login();
                  setState(() {});
                },
              );
              // return Intro(primaryButtonOnPressed: () async {

              // });
            }
          },
        ),
        // home:RegistrationScreen()
        // initialRoute: home,
        routes: {
          //'/': (ctx) => MyHomePage(),
          CommunityProfileScreen.routeName: (ctx) => CommunityProfileScreen(),
          UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
          BlockedScreen.routeName: (ctx) => BlockedScreen(),
          ManagersScreen.routeName: (ctx) => ManagersScreen(),
          AddEventsScreen.routeName: (ctx) => AddEventsScreen(),
          SearchScreen.routeName: (ctx) => SearchScreen(),
          ProfileInfoScreen.routeName: (ctx) => ProfileInfoScreen(),
          // UserProfileScreen.routeName: (
          //   ctx,
          // ) =>
          //     UserProfileScreen(
          //       userId: id,
          //     ),
        },
      ),
    );
  }

  Widget buildLoading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Center(
          child: Container(
            width: 70,
            child: Image.asset('images/cambuzz_icon.png'),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  User.User myself;
  MyHomePage() {
    this.myself = myself;

    //Global.myself = myself;
  }
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPageIndex;
  PageController _pageController;
  List<Widget> _pages;
  //bool registrationJustCompleted = false;
  var user;

  void initializePages() {
    _pages = [
      FeedScreen(),
      SearchScreen(),
      TrendingScreen(),
      EventScreen(),
    ];
  }

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;

    initializePages();

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  // Future init() async {
  //   final uid = await SecureStorage.readUid();
  //   Global.uid = uid;
  //   print(Global().uid);
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final shouldReload = await showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => AddPost(
                    context,
                  ),
                ) ??
                false;
            // shouldReload = true;
            if (shouldReload)
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => super.widget));
          },
          tooltip: 'Increment',
          child: Container(
            child: Icon(
              Icons.add,
              size: 30,
            ),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle, gradient: kLinearGradient),
          ),
          elevation: 2.0,
        ),
        body: PageView(
          controller: _pageController,
          children: _pages,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 1,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              // selectedLabelStyle: ,
              currentIndex: _selectedPageIndex,
              onTap: (index) {
                setState(() {
                  _selectedPageIndex = index;
                  _pageController.jumpToPage(index);
                });
              },
              selectedItemColor: kPrimaryColor,
              items: [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.home), label: 'Feed'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.search), label: 'Search'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.fire), label: 'Trending'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
                    label: 'Events'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
