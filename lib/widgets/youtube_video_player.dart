import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerCard extends StatefulWidget {
  final String videoId;
  const YouTubePlayerCard({super.key, required this.videoId});

  @override
  State<YouTubePlayerCard> createState() => _YouTubePlayerCardState();
}

class _YouTubePlayerCardState extends State<YouTubePlayerCard> {
  YoutubePlayerController? _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller!,
      showVideoProgressIndicator: false,
      progressIndicatorColor: Colors.blue,
      progressColors: const ProgressBarColors(
        playedColor: Colors.blue,
        handleColor: Colors.blue,
      ),
      onReady: () {},
    );
  }
}
