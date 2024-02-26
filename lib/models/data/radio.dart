import 'package:equatable/equatable.dart';
import 'package:listradios/models/data/id.dart';

class Radios extends Equatable {
  final ID<Radios> id;
  final String name;
  final String url;
  final int votes;
  final int playCount;
  final String image;
  final List<String> tags;
  final String country;

  const Radios({
    required this.id,
    required this.name,
    required this.url,
    required this.votes,
    required this.playCount,
    required this.image,
    required this.tags,
    required this.country,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    url,
    votes,
    playCount,
    image,
    tags,
    country,
  ];
}
