import 'package:flutter/material.dart';
import 'package:playmusic/globals.dart';
import 'package:playmusic/models/music.dart';
import 'package:playmusic/views/home.dart';
import 'package:playmusic/views/search.dart';
import 'package:playmusic/views/yourlibrary.dart';
import 'package:playmusic/views/music_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Use the global audio player
  AudioPlayer _audioPlayer = GlobalPlayerState.audioPlayer;
  var Tabs = [];
  int currentTabIndex = 0;

  List<Music> playlist = [];
  int currentIndex = 0;
  bool isLoop = false;

  @override
  void initState() {
    super.initState();
    Tabs = [Home(miniPlayer), Search(), YourLibrary()];
  }

  Future<void> _loadTrack(Music music) async {
    final yt = YoutubeExplode();
    final searchResult =
        await yt.search.search("${music.songName} ${music.artistName}");
    if (searchResult.isNotEmpty) {
      final videoId = searchResult.first.id.value;
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var audioUrl = manifest.audioOnly.last.url;
      await _audioPlayer.play(UrlSource(audioUrl.toString()));
      GlobalPlayerState.currentMusic.value = music;
      GlobalPlayerState.isPlaying.value = true;
      setState(() {}); // Ensure state is updated to reflect changes in UI
    }
  }

  void _playNextSong() {
    if (currentIndex < playlist.length - 1) {
      currentIndex++;
      _loadTrack(playlist[currentIndex]);
    } else if (isLoop) {
      currentIndex = 0;
      _loadTrack(playlist[currentIndex]);
    }
  }

  void _playPreviousSong() {
    if (currentIndex > 0) {
      currentIndex--;
      _loadTrack(playlist[currentIndex]);
    }
  }

  Widget miniPlayer(Music? music, {bool stop = false}) {
    if (stop) {
      GlobalPlayerState.isPlaying.value = false;
      _audioPlayer.stop();
    }
    Size deviceSize = MediaQuery.of(context).size;
    return ValueListenableBuilder<Music?>(
      valueListenable: GlobalPlayerState.currentMusic,
      builder: (context, currentMusic, _) {
        if (currentMusic == null) {
          return SizedBox();
        }
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: Colors.blueGrey,
          width: deviceSize.width,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicPlayer(
                        music: currentMusic,
                        player: _audioPlayer,
                        isPlaying: GlobalPlayerState.isPlaying.value,
                        onNext: _playNextSong,
                        onPrevious: _playPreviousSong,
                        isLoop: isLoop,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Image.network(
                      currentMusic.songImage!,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentMusic.songName!,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          currentMusic.artistName!,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: GlobalPlayerState.isPlaying,
                builder: (context, isPlaying, _) {
                  return IconButton(
                    onPressed: () async {
                      GlobalPlayerState.isPlaying.value = !isPlaying;
                      if (GlobalPlayerState.isPlaying.value) {
                        await _audioPlayer.resume();
                      } else {
                        await _audioPlayer.pause();
                      }
                    },
                    icon: isPlaying
                        ? Icon(Icons.pause, color: Colors.white)
                        : Icon(Icons.play_arrow, color: Colors.white),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tabs[currentTabIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          miniPlayer(GlobalPlayerState.currentMusic.value),
          BottomNavigationBar(
            currentIndex: currentTabIndex,
            onTap: (currentIndex) {
              currentTabIndex = currentIndex;
              setState(() {});
            },
            selectedLabelStyle: TextStyle(color: Colors.white),
            selectedItemColor: Colors.white,
            backgroundColor: Colors.black45,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.white), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search, color: Colors.white),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books, color: Colors.white),
                  label: 'Your Library')
            ],
          ),
        ],
      ),
    );
  }
}
