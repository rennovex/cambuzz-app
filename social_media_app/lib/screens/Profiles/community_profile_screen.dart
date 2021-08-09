import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/appBars/transparent_appbar.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/screens/Profiles/community_settings.dart';
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

  @override
  void initState() {
    super.initState();
    future = widget.uid == null
        ? Api.getCommunity()
        : Api.getCommunityWithId(widget.uid);
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
                  child: Text('Create a community'),
                ),
              );
            } else {
              community = snapshot.data;
              isOwner = community.owner.uid == Global.uid ? true : false;
              print(community.owner.uid + '  ' + Global.uid);
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
                          Row(
                            children: [
                              Icon(
                                Icons.wallet_membership_outlined,
                                color: Colors.red,
                              ),
                              Text(
                                '${community.membersCount ?? 0} Members',
                                style: kProfileLabel,
                              ),
                            ],
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
