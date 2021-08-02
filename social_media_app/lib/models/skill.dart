class Skill{
  String name;
  String shortName;
  String id;
  Skill({name, shortName, id}){
    this.name = name;
    this.shortName = shortName;
    this.id = id;
  }

  factory Skill.fromJson(Map json){
    return new Skill(name: json['name'], shortName: json['shortName'], id:json['_id']);
  }
}