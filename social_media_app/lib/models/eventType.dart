class EventType {
  final String id;
  final String name;
  final String image;

  EventType({this.id, this.image, this.name});

  factory EventType.fromJson(Map json) {
    return EventType(
      name: json['name'],
      id: json['_id'],
      image: json['image'],
    );
  }
}
