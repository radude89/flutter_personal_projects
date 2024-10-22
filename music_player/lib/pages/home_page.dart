import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playListProvider;

  @override
  void initState() {
    super.initState();
    playListProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int index) {
    playListProvider.currentSongIndex = index;
    Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => const SongPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("PLAYLIST"),
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        final List<Song> playlist = value.playlist;
        return ListView.builder(
          itemCount: playlist.length,
          itemBuilder: (context, index) {
            final Song song = playlist[index];

            return ListTile(
              title: Text(song.name),
              subtitle: Text(song.artist),
              leading: Image.asset(song.albumArtImagePath),
              onTap: () => goToSong(index),
            );
          }
        );
      }),
    );
  }
}
