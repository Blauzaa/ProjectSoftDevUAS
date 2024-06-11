import 'package:flutter/material.dart';
import 'package:playmusic/globals.dart';
import 'package:playmusic/models/category.dart';
import 'package:playmusic/models/music.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:playmusic/views/music_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:playmusic/services/category_operations.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  CategoryScreen({required this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late AudioPlayer _audioPlayer;
  List<Music> playlist = [];
  int currentIndex = 0;
  bool isLoop = false;
  bool _isCompleting = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = GlobalPlayerState.audioPlayer;
    _fetchPlaylist().then((songs) {
      setState(() {
        playlist = songs;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      if (!_isCompleting) {
        _isCompleting = true;
        _onTrackComplete();
      }
    });
  }

  Future<List<Music>> _fetchPlaylist() async {
    List<Category> categories = await CategoryOperations.getCategories();
    return categories
        .firstWhere((category) => category.name == widget.category.name)
        .songs;
  }

  void _loadTrack(Music music) async {
    final yt = YoutubeExplode();
    try {
      final searchResult =
          await yt.search.search("${music.songName} ${music.artistName}");
      if (searchResult.isNotEmpty) {
        final videoId = searchResult.first.id.value;
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.last.url;
        await _audioPlayer.play(UrlSource(audioUrl.toString()));
        Duration? duration = await _audioPlayer.getDuration();
        if (duration != null) {
          music.duration = duration;
        }
        GlobalPlayerState.currentMusic.value = music;
        GlobalPlayerState.isPlaying.value = true;
        setState(() {});
      }
    } catch (e) {
      print("Error loading track: $e");
    }
  }

  void _playNextSong() {
    if (currentIndex < playlist.length - 1) {
      currentIndex++;
    } else if (isLoop) {
      currentIndex = 0; // Start from the beginning if looping is enabled
    } else {
      return; // Do nothing if not looping and at the end of the playlist
    }
    _loadTrack(playlist[currentIndex]);
    print("Playing next song: ${playlist[currentIndex].songName}");
  }

  void _playPreviousSong() {
    if (currentIndex > 0) {
      currentIndex--;
    } else if (isLoop) {
      currentIndex =
          playlist.length - 1; // Go to the last song if looping is enabled
    } else {
      return; // Do nothing if not looping and at the beginning of the playlist
    }
    _loadTrack(playlist[currentIndex]);
    print("Playing previous song: ${playlist[currentIndex].songName}");
  }

  void _onTrackComplete() {
    if (currentIndex < playlist.length - 1) {
      print("Track complete next song: ${playlist[currentIndex].songName}");
      _playNextSong();
    } else if (isLoop) {
      print("Looping back to first song: ${playlist[currentIndex].songName}");
      currentIndex = 0; // Start from the beginning if looping is enabled
      _loadTrack(playlist[currentIndex]);
    } else {
      _audioPlayer.stop();
      GlobalPlayerState.isPlaying.value = false;
      print("Stopping playback");
    }
    _isCompleting = false; // Reset the flag
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
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: FutureBuilder<List<Music>>(
        future: _fetchPlaylist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No songs available'));
          } else {
            playlist = snapshot.data!;
            return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                Music song = playlist[index];
                return ListTile(
                  leading: song.songImage != null
                      ? Image.network(song.songImage!)
                      : null,
                  title: Text(song.songName ?? 'Unknown Song'),
                  subtitle: Text(song.artistName ?? 'Unknown Artist'),
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                    _loadTrack(song);
                  },
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar:
          miniPlayer(playlist.isNotEmpty ? playlist[currentIndex] : null),
    );
  }
}
