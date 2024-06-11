import 'package:flutter/material.dart';
import 'package:playmusic/models/category.dart';
import 'package:playmusic/models/music.dart';
import 'package:playmusic/services/category_operations.dart';
import 'package:playmusic/services/music_operations.dart';
import 'package:playmusic/views/categoryscreen.dart';
import 'package:playmusic/globals.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:audioplayers/audioplayers.dart';

class Home extends StatelessWidget {
  final Function _miniPlayer;

  Home(this._miniPlayer);

  Widget createCategory(Category category, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              category: category,
            ),
          ),
        );
      },
      child: Container(
        color: Colors.blueGrey.shade400,
        child: Row(
          children: [
            Image.network(category.imageURL, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                category.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Widget>> createListOfCategories(BuildContext context) async {
    List<Category> categoryList = await CategoryOperations.getCategories();
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category, context))
        .toList();
    return categories;
  }

  Future<void> _loadAndPlayTrack(Music music) async {
    final yt = YoutubeExplode();
    final searchResult =
        await yt.search.search("${music.songName} ${music.artistName}");
    if (searchResult.isNotEmpty) {
      final videoId = searchResult.first.id.value;
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var audioUrl = manifest.audioOnly.last.url;
      await GlobalPlayerState.audioPlayer.play(UrlSource(audioUrl.toString()));
      GlobalPlayerState.currentMusic.value = music;
      GlobalPlayerState.isPlaying.value = true;
    }
  }

  Widget createMusic(Music music) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 200,
            child: InkWell(
              onTap: () async {
                await _loadAndPlayTrack(music);
                _miniPlayer(music, stop: false); // Ensure mini player shows
              },
              child: Image.network(
                music.songImage ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            ),
          ),
          Text(
            music.songName ?? 'Unknown Song',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            music.artistName ?? 'Unknown Artist',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget createMusicList(String label, AsyncSnapshot<List<Music>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      List<Music> musicList = snapshot.data!;
      return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return createMusic(musicList[index]);
                },
                itemCount: musicList.length,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget createGrid(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: createListOfCategories(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Container(
            padding: EdgeInsets.all(10),
            height: 280,
            child: GridView.count(
              childAspectRatio: 5 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: snapshot.data!,
              crossAxisCount: 2,
            ),
          );
        }
      },
    );
  }

  Widget createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(message),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 10), child: Icon(Icons.settings))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Music>>(
      future: MusicOperations.getMusic(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Music> musicList = snapshot.data!;
          return SingleChildScrollView(
            child: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    createAppBar('Good morning'),
                    SizedBox(height: 5),
                    createGrid(context),
                    createMusicList('Made for you', snapshot),
                    createMusicList('Popular PlayList', snapshot),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueGrey.shade300, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.1, 0.3],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
