// import 'package:flutter/material.dart';

// import 'views/music_player.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mobile Music Player',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MusicPlayer(),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playmusic/views/app.dart';

void main() {
  runApp(MaterialApp(
      title: 'Spotify Clone',
      debugShowCheckedModeBanner: false,
      home: MyApp()));
}


//list:
//sistem looping masih agak error 