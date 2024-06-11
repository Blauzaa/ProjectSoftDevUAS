import 'package:playmusic/models/music.dart';

class Category {
  String name;
  String imageURL;
  List<Music> songs;
  Category(this.name, this.imageURL, this.songs);
}
