import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/models/eventType.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/myself.dart';
import 'package:social_media_app/screens/Registration/registration_screen.dart';
import 'package:social_media_app/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/event.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key key}) : super(key: key);

  //EventScreen(this.events);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
    with AutomaticKeepAliveClientMixin<EventScreen> {
  Future<List<Event>> events;
  Future eventTypes;

  EventType selectedEventType;

  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];

  @override
  void initState() {
    super.initState();
    events = Api.getEvents();
    eventTypes = Api.getEventTypes();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedEventType?.name);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration.zero,
          ).then((value) => setState(() {}));
        },
        child: Scaffold(
          appBar: PreferredSize(
            child: CustomAppBar(
                Provider.of<Myself>(context, listen: false).myself),
            preferredSize: kAppBarPreferredSize,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 14),
                      child: Text(
                        'Filter events',
                        style: kTitleTextStyle,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        return setState(() {
                          selectedEventType = null;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text('View All'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 136,
                  child: FutureBuilder(
                    future: eventTypes,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.length,
                          shrinkWrap: true,
                          itemBuilder: (_, ind) => GestureDetector(
                            onTap: () {
                              return setState(() {
                                selectedEventType = snapshot.data[ind];
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                padding: selectedEventType == snapshot.data[ind]
                                    ? EdgeInsets.all(8)
                                    : EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: Image.network(
                                      snapshot.data[ind]?.image,
                                      // height: 136,
                                      // width: 112,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 18),
                  child: Text(
                    'Upcoming events',
                    style: kTitleTextStyle,
                  ),
                ),
                FutureBuilder(
                  future: selectedEventType == null
                      ? Api.getEvents()
                      : Api.getEventsWithFilterId(selectedEventType.id),
                  builder: (context, snapshot) {
                    print(selectedEventType?.name);

                    if (snapshot.hasData && snapshot.data.length > 0) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, ind) => GestureDetector(
                          onTap: () => expandEvent(
                            context: context,
                            event: snapshot.data[ind],
                          ),
                          child: EventItem(snapshot.data[ind]),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SpinKitWave(
                        color: kPrimaryColor,
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Center(
                          child: Text('No Upcoming Events'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  expandEvent({context, Event event}) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Color.fromRGBO(255, 255, 255, 0.75),
            ),
            // margin: EdgeInsets.only(
            //   top: 20,
            //   left: 10,
            //   right: 10,
            //   bottom: 90,
            // ),
            child: Column(
              children: [
                Stack(
                  // alignment: Alignment.topLeft,
                  // clipBehavior: Clip.none,
                  // alignment: Alignment(0.0, 0.0),
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: MediaQuery.of(context).size.height * 0.9,

                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(18)),
                      // margin: EdgeInsets.only(
                      //   top: 20,
                      //   left: 10,
                      //   right: 10,
                      //   bottom: 90,
                      // ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: CachedNetworkImage(
                          imageUrl: event.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      left: 0,
                      top: MediaQuery.of(context).size.height * 0.35,
                      child: Container(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        width: MediaQuery.of(context).size.width * 0.95,
                        // alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // width: double.infinity,
                                  // alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            event.time.day.toString(),
                                            style: kEventExpandedDay,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            months[event.time.month - 1],
                                            style: kEventExpandedMonth,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${event.time.hour}:${event.time.minute}',
                                            style: kEventExpandedTime,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 25),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 2,
                                          horizontal: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Color.fromRGBO(98, 65, 234, 1),
                                        ),
                                        child: Text(
                                          event.tag,
                                          style: kEventBadge,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  event.name,
                                  style: kEventExpandedName,
                                ),
                                Text(
                                  event.community.name,
                                  style: kEventExpandedCommunityName,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 300,
                                  // constraints: BoxConstraints(
                                  //     maxHeight:
                                  //         MediaQuery.of(context).size.height *
                                  //             0.2),
                                  child: Text(
                                    event.description,
                                    style: kEventExpandedDescription,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 6,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      launch("tel://${event.contact}");
                                    },
                                    child: Text('Contact'),
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
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 38,
                                    decoration: BoxDecoration(
                                        gradient: kButtonLinearGradient,
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.purple),
                                    child: TextButton(
                                      onPressed: () {
                                        launch(event.link);
                                        print('pressed');
                                      },
                                      child: Text(
                                        'Register',
                                        textAlign: TextAlign.center,
                                      ),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        // backgroundColor: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        left: 10,
                        top: 10,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class EventItem extends StatelessWidget {
  final Event event;

  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];

  EventItem(this.event);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10,
        bottom: 20,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 3,
      color: Color(0xff303030),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: CachedNetworkImage(
              imageUrl: event.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Color.fromRGBO(229, 229, 229, 1),
                      ),
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Text(
                            months[event.time.month - 1],
                            style: kEventMonth,
                          ),
                          Text(
                            event.time.day.toString(),
                            style: kEventDate,
                          ),
                          Text(
                            '${event.time.hour}:${event.time.minute}',
                            style: kEventTime,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  right: 10,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${event.community.name}',
                      style: kEventCommunityName,
                    ),
                    Text(
                      '${event.name}',
                      style: kEventHeader,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        '${event.description}',
                        style: kEventBody,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color.fromRGBO(98, 65, 234, 1),
                      ),
                      child: Text(
                        '${event.tag}',
                        style: kEventBadge,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
