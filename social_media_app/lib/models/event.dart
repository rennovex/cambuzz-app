import 'package:social_media_app/models/community.dart';

class Event {
  final String id;
  final String image;
  final Community community;
  final String name;
  final String description;
  final String tag;
  final DateTime time;
  final String contact;
  final String link;

  Event({
    this.id,
    this.image,
    this.community,
    this.description,
    this.name,
    this.tag,
    this.time,
    this.contact,
    this.link,
  });


  factory Event.fromJson(json){
    Community community = Community.fromJson(json['community']);
    var id = json['_id'];
    var image = json['image'];
    var description = json['description'];
    var name = json['title'];
    var tag = json['eventType']['name'];
    var time = DateTime.parse(json['time']);
    var contact = json['contact'];
    var link = json['link'];
    Event event = new Event(
      id:id,
      image:image,
      community: community,
      description: description,
      name: name,
      tag: tag,
      time: time,
      contact: contact,
      link: link
      );
    return event;
  }
  
}
