import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      name: "Lose yourself",
      artist: "Eminem",
      albumArtImagePath: "assets/images/a1.png",
      audioPath: "assets/audio/lose_yourself.mp3"
    ),
    Song(
        name: "Not afraid",
        artist: "Eminem",
        albumArtImagePath: "assets/images/a2.png",
        audioPath: "assets/audio/lose_yourself.mp3"
    ),
    Song(
        name: "Stan",
        artist: "Eminem",
        albumArtImagePath: "assets/images/a3.png",
        audioPath: "assets/audio/lose_yourself.mp3"
    )
  ];
  int? _currentSongIndex;

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
}
