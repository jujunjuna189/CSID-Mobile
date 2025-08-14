import 'package:csid_mobile/utils/theme/theme.dart';
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
  late YoutubePlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.source) ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _videoController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: ThemeApp.color.light,
      progressColors: ProgressBarColors(
        playedColor: ThemeApp.color.primary,
        handleColor: ThemeApp.color.primary,
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
