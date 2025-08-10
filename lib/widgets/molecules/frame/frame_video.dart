import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FrameVideo extends StatefulWidget {
  const FrameVideo({super.key, required this.source, required this.thumbnail});
  final String source;
  final String thumbnail;

  @override
  State<FrameVideo> createState() => _FrameVideoState();
}

class _FrameVideoState extends State<FrameVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String id = getId();
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  String getId() {
    String lasPath = widget.source.split("/").last;
    return lasPath;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: const ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
      thumbnail: Image.network(
        widget.thumbnail,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image, size: 50, color: Colors.grey);
        },
      ),
      onReady: () {},
    );
  }
}
