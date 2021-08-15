import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/secureStorage.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/google_sign_in.dart';
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
import 'package:social_media_app/screens/profile_screen.dart';
import 'package:social_media_app/screens/Registration/registration_screen.dart';
import 'package:social_media_app/screens/search_screen.dart';
import 'package:social_media_app/screens/trending_screen.dart';
import 'package:social_media_app/widgets/add_post_modal_sheet.dart';
import 'package:social_media_app/models/user.dart' as User;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Global.apiToken = await SecureStorage.readApiToken() ?? '';
  Global.uid = await SecureStorage.readUid() ?? '';
  print('uid = ' + Global.uid);
  print('token = ' + Global.apiToken);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GoogleSignInProvider()),
        // ChangeNotifierProvider.value(value: Api()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
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
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(
              context,
            );
            if (provider.isSigningIn) {
              return buildLoading();
            } else if (snapshot.hasData) {
              Global.firebaseUser = snapshot.data;
              return SplashScreen(
                firebaseUser: snapshot.data,
              );
            } else {
              print('not firebase logged in');
              return Intro(primaryButtonOnPressed: () async {
                String name, userName, email, bio, firebaseUid;
                XFile image;
                List<String> skills;

                var firebaseData = await provider.login();
                email = firebaseData['email'];
                firebaseUid = firebaseData['uid'];

                print('vaiting for user registration');

                var userData =
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Step1(
                              onPrimaryButtonPressed: () {},
                              email: email,
                            )));
                name = userData['name'];
                userName = userData['username'];
                email = userData['email'];

                var imageData = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Step2()));
                image = imageData['image'];

                var bioData = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Step3()));

                bio = bioData['bio'];
                skills = bioData['skills'];

                User.User user = User.User(
                    name: name,
                    email: email,
                    userName: userName,
                    bio: bio,
                    skills: skills);

                var status = await Api.postUser(user, firebaseUid, image);

                if (status['status']) {
                  print('success');
                  Global.uid = status['uid'];
                  Global.apiToken = status['token'];
                  Global.myself = user;
                  //TODO: if user does not select image, show default dp
                }

                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => End(
                          primaryButtonOnPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()));
                          },
                        )));
              });
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

class SplashScreen extends StatefulWidget {
  final firebaseUser;
  SplashScreen({@required this.firebaseUser});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var googleProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    googleProvider = Provider.of<GoogleSignInProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // if (Global.myself == null) {
    //   SecureStorage.readUser().then((value) {
    //     if (value.name != null) {
    //       print('user found locally');
    //       Global.myself = value;
    //       setState(() {});
    //     }
    //   });

    print('Starting splash screen');
    return FutureBuilder(
        future: Api.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (snapshot.error.toString() == '401') {
              print('we got a 401 error');
              Api.isUserRegistered(widget.firebaseUser.email).then((value) {
                print('we got a response for isuserregistered');
                if (value) {
                  print('trying login');
                  Api.login(widget.firebaseUser.email, widget.firebaseUser.uid)
                      .then((value) {
                    if (value['status']) {
                      print('login successful');
                      Global.uid = widget.firebaseUser.uid;
                      Global.apiToken = value['token'];
                      Global.myself = value['user'];
                      print(
                          'User has been set up with token ${Global.apiToken}, username ${Global.myself.userName}');
                      setState(() {});
                    } else {
                      //TODO: credentials invalid
                      print('invalid credentials');
                      googleProvider.logout();

                      // FirebaseAuth.instance.currentUser.delete();
                      //   FirebaseAuth.instance.currentUser.delete();
                    }
                  });
                } else {
                  print('user is not registered');
                  googleProvider.logout();
                  // FirebaseAuth.instance.currentUser.delete();
                  // FirebaseAuth.instance.currentUser.delete();
                }
              });
            }
          } else {
            if (Global.myself == null)
              return SpinKitCircle(
                color: kPrimaryColor,
              );
            return MyHomePage();
          }

          return SpinKitCircle(
            color: kPrimaryColor,
          );

          // if (snapshot.hasError) {
          //   if (snapshot.error.toString() == '401') {
          //     // return RegistrationScreen(true, email: Global.firebaseUser.email,
          //     //     onRegistrationError: () {
          //     //   //TODO: app restart
          //     // }, onRegistrationComplete: () {
          //     //   setState(() {
          //     //     //rebuilds app here
          //     //   });
          //     // });
          //   }
          // }
          // if (!snapshot.hasData) {
          //   print('waiting for user data from server');
          //   return SpinKitChasingDots(
          //     color: kPrimaryColor,
          //   );
          // } else {
          //   print('got data from server');
          //   print(snapshot.data.name);
          //   Global.myself = snapshot.data;
          //   SecureStorage.setUser(Global.myself);
          //   return MyHomePage();
          // }
        });
  }

  // Widget returnWidget;
  // if (Provider.of<Myself>(context).myself == null) {
  //   Api.getUser().then((user) {
  //     print('user = ' + user.toString());
  //     Provider.of<Myself>(context, listen: false).setMyself(user);
  //     returnWidget = MyHomePage();
  //   }).catchError((error) {
  //     if (error.toString() == '401') {
  //       print('profile not created');
  //       returnWidget =
  //           RegistrationScreen(true, email: '', onRegistrationComplete: () {
  //         //TODO: add registration logic here
  //         // setState(() {
  //         //   registrationJustCompleted = true;
  //         // });
  //       });
  //     } else if (error.toString() == '404') {
  //       print('user not found');
  //     } else {}
  //   });
  // }
  // print(returnWidget);

  // return returnWidget == null
  //     ?
  //     : returnWidget;

}

class MyHomePage extends StatefulWidget {
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
    print(_pages);

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
          onPressed: () => showModalBottomSheet<dynamic>(
            isScrollControlled: true,
            context: context,
            builder: (context) => AddPost(context),
          ),
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
              currentIndex: _selectedPageIndex,
              onTap: (index) {
                setState(() {
                  _selectedPageIndex = index;
                  _pageController.jumpToPage(index);
                });
              },
              selectedItemColor: kPrimaryColor,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.trending_up), label: 'Trending'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today_outlined), label: 'Events'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
