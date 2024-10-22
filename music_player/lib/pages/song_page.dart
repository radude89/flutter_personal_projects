import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration) {
    String twoDigitSeconds =
      duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {
          final playlist = playlistProvider.playlist;
          final currentSong = playlist[playlistProvider.currentSongIndex ?? 0];
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Text("PLAYLIST"),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.menu),
                        ),
                      ],
                    ),
                    NeuBox(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(currentSong.albumArtImagePath),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentSong.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),
                                      ),
                                      Text(currentSong.artist)
                                    ],
                                  ),
                                  const Icon(Icons.favorite, color: Colors.red)
                                ],
                              ),
                            )
                          ],
                        )
                    ),

                    const SizedBox(height: 25),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatTime(playlistProvider.currentDuration)
                              ),
                              const Icon(Icons.shuffle),
                              const Icon(Icons.repeat),
                              Text(
                                  formatTime(playlistProvider.totalDuration)
                              )
                            ],
                          ),
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0)
                          ),
                          child: Slider(
                            min: 0,
                            max: playlistProvider.totalDuration.inSeconds.toDouble(),
                            value: playlistProvider.currentDuration.inSeconds.toDouble(),
                            activeColor: Colors.green,
                            inactiveColor: Colors.grey,
                            onChanged: (valueAsDouble) {
                            },
                            onChangeEnd: (valueAsDouble) {
                              playlistProvider.seek(
                                Duration(seconds: valueAsDouble.toInt())
                              );
                            },
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                              onTap: playlistProvider.playPreviousSong,
                              child: const NeuBox(
                                  child: Icon(Icons.skip_previous)
                              ),
                            )
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: playlistProvider.pauseOrResume,
                              child: NeuBox(
                                  child: Icon(
                                      playlistProvider.isPlaying ?
                                      Icons.pause :
                                      Icons.play_arrow
                                  )
                              ),
                            )
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: GestureDetector(
                              onTap: playlistProvider.playNextSong,
                              child: const NeuBox(
                                  child: Icon(Icons.skip_next)
                              ),
                            )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
