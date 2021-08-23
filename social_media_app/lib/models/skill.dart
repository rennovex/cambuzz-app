class Skill {
  String name;
  String shortName;
  String id;
  String image;

  Skill({this.name, this.shortName, this.id, this.image});

  factory Skill.fromJson(Map json) {
    return new Skill(
      name: json['name'],
      shortName: json['shortName'],
      id: json['_id'],
      image: json['image'],
    );
  }
}
