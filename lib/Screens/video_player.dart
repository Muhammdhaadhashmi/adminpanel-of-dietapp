import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Utils/app_colors.dart';

class VideoPlayer extends StatefulWidget {
  final String value;

  const VideoPlayer({Key? key, required this.value}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {


  // final videoUrl="";

  late YoutubePlayerController _controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String videoID=YoutubePlayer.convertUrlToId(widget.value)!;
    _controller=YoutubePlayerController(
      initialVideoId:videoID,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        useHybridComposition: false,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.mainColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(controller: _controller,
            showVideoProgressIndicator: true,
            onReady: ()=>debugPrint('Ready'),
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
              ),
              PlaybackSpeedButton(

              )
            ],
          )
        ],
      ),
    );
  }
}
