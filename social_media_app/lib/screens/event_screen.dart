import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/event.dart';

class EventScreen extends StatefulWidget {
  // const Event({ Key? key }) : super(key: key);
  final List<Event> events;

  EventScreen(this.events);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  expandEvent({context, eventName, communityName, description}) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Color.fromRGBO(255, 255, 255, 0.75),
            ),
            margin: EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
              bottom: 90,
            ),
            child: Column(
              children: [
                Stack(
                  // alignment: Alignment.topLeft,
                  // clipBehavior: Clip.none,
                  // alignment: Alignment(0.0, 0.0),
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: MediaQuery.of(context).size.height * 0.82,

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
                        child: Image.network(
                          'https://images.unsplash.com/photo-1514533212735-5df27d970db0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fG1hcnNobWVsbG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      left: 0,
                      top: 270,
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

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '23',
                                            style: kEventExpandedDay,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'MAY',
                                            style: kEventExpandedMonth,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '7:00 PM',
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
                                          'hackathon',
                                          style: kEventBadge,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '$eventName',
                                  style: kEventExpandedName,
                                ),
                                Text(
                                  '$communityName',
                                  style: kEventExpandedCommunityName,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 300,
                                  height:
                                      MediaQuery.of(context).size.height * 0.22,
                                  child: Text(
                                    '$description',
                                    style: kEventExpandedDescription,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 8,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      launch('https://www.rennovex.com/');

                                      Navigator.of(context).pop();
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
                                        launch('https://www.rennovex.com/');
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: widget.events.length,
        itemBuilder: (ctx, ind) => GestureDetector(
          onTap: () => expandEvent(
            context: context,
            communityName: widget.events[ind].communityName,
            description: widget.events[ind].description,
            eventName: widget.events[ind].eventName,
          ),
          child: EventItem(
            eventName: widget.events[ind].eventName,
            communityName: widget.events[ind].communityName,
            image: widget.events[ind].image,
            description: widget.events[ind].description,
            tag: widget.events[ind].tag,
          ),
        ),
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final String image;
  final String communityName;
  final String eventName;
  final String description;
  final String tag;

  EventItem({
    @required this.image,
    @required this.communityName,
    @required this.description,
    @required this.eventName,
    @required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: Image.network(
              '$image',
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
                            'APR',
                            style: kEventMonth,
                          ),
                          Text(
                            '27',
                            style: kEventDate,
                          ),
                          Text(
                            '7:30 PM',
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
                      '\$${communityName}',
                      style: kEventCommunityName,
                    ),
                    Text(
                      '$eventName',
                      style: kEventHeader,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        '$description',
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
                        '$tag',
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
