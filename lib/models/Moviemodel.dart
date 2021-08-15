import 'package:hive/hive.dart';

part 'Moviemodel.g.dart';

@HiveType(typeId: 0)
class MovieModel {

  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? director;

  @HiveField(2)
  final String? imgpath;

  MovieModel({this.name, this.director,this.imgpath});

}