import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';

class EventScreen extends StatelessWidget {
  // const Event({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                'https://images.unsplash.com/photo-1514533212735-5df27d970db0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fG1hcnNobWVsbG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
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
                        '\$IEEE',
                        style: kEventCommunityName,
                      ),
                      Text(
                        'Event Header',
                        style: kEventHeader,
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          'Post Lorem Ipsum is simply dummy text of the printing and typesetting industry afnsnfksnfsfsf sdfn;sdf',
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
                          'Hackathon',
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
      ),
    );
  }
}
