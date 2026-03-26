import 'package:hive/hive.dart';

part 'hive_character_model.g.dart';

@HiveType(typeId: 0)
class CharacterModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String image;

  @HiveField(3)
  String species;

  @HiveField(4)
  String status;

  @HiveField(5)
  String type;

  @HiveField(6)
  String gender;

  @HiveField(7)
  String origin;

  @HiveField(8)
  String location;

  @HiveField(9)
  bool isFavorite;


  CharacterModel({
    required this.id,
    required this.name,
    required this.image,
    required this.species,
    required this.status,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.isFavorite,
  });

}