import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
        builder: (context, value, child) => Scaffold(
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
                  const SizedBox(height: 25),
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset("assets/images/a1.png"),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Eminem",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                  ),
                                  Text("Loose yourself")
                                ],
                              ),
                              Icon(Icons.favorite, color: Colors.red)
                            ],
                          ),
                        )
                      ],
                    )
                  ),

                  const SizedBox(height: 25),

                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("0:00"),
                            Icon(Icons.shuffle),
                            Icon(Icons.repeat),
                            Text("0:00")
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0)
                        ),
                        child: Slider(
                          min: 0,
                          max: 100,
                          value: 50,
                          activeColor: Colors.green,
                          inactiveColor: Colors.lightGreen,
                          onChanged: (value) {},
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 25),
                  
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: const NeuBox(
                              child: Icon(Icons.skip_previous)
                          ),
                        )
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {},
                          child: const NeuBox(
                              child: Icon(Icons.play_arrow)
                          ),
                        )
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
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
        )
    );
  }
}
