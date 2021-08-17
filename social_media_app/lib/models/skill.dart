class Skill {
  String name;
  String shortName;
  String id;

  Skill({this.name, this.shortName, this.id});

  factory Skill.fromJson(Map json) {
    return new Skill(
        name: json['name'], shortName: json['shortName'], id: json['_id']);
  }
}
