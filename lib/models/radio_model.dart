import 'package:listradios/models/data/id.dart';
import 'package:listradios/models/data/radio.dart';

class RadioModel extends Radios {
  const RadioModel({
    required super.id,
    required super.name,
    required super.url,
    required super.votes,
    required super.playCount,
    required super.image,
    required super.tags,
    required super.country,
  });

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    return RadioModel(
      id: ID(json['stationuuid']),
      name: json['name'],
      url: json['url'],
      votes: json['votes'],
      playCount: json['clickcount'],
      image: json['favicon'],
      tags: json['tags'].split(','),
      country: json['country'],
    );
  }
}
