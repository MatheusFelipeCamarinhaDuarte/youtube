import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerScreen extends StatefulWidget {
  final String videoId;
  const PlayerScreen({super.key, required this.videoId});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
        )
    );
    return Scaffold(

      //appBar: AppBar(title: Text('Player'),),
      body: Center(

        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
        )
      ),
    );
  }
}
