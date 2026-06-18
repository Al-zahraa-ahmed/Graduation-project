import 'package:flutter/material.dart';
import 'package:graduation_project/data/Models/CategoryModel.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/presentation/ErrorsScreens/NotFound.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Plays a YouTube lesson video. Backend serves all lesson `link`s as
/// `https://youtu.be/{id}?si=...` URLs, which `video_player` cannot play
/// directly — hence the dedicated YouTube embed.
///
/// Optional [desc] renders the bilingual "Hand Description" card under the
/// player. Optional [onCompleted] fires exactly once when the user finishes
/// the video — used by [LessonsScreen] to auto-mark the lesson as done.
class LessonVideoScreen extends StatefulWidget {
  const LessonVideoScreen({
    super.key,
    required this.videoUrl,
    required this.title,
    this.desc,
    this.onCompleted,
  });

  final String videoUrl;
  final String title;
  final LocalizedText? desc;
  final VoidCallback? onCompleted;

  @override
  State<LessonVideoScreen> createState() => _LessonVideoScreenState();
}

class _LessonVideoScreenState extends State<LessonVideoScreen> {
  YoutubePlayerController? _controller;
  bool _completedFired = false;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId == null) {
      // Bad URL — bounce to NotFound after first frame so the route is set up.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NotFoundPage()),
        );
      });
      return;
    }
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
      ),
    )..addListener(_onPlayerEvent);
  }

  void _onPlayerEvent() {
    final c = _controller;
    if (c == null) return;
    if (!_completedFired && c.value.playerState == PlayerState.ended) {
      _completedFired = true;
      widget.onCompleted?.call();
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onPlayerEvent);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = _controller;
    if (c == null) {
      // While the post-frame callback re-routes to NotFound.
      return const Scaffold(body: SizedBox.shrink());
    }
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: c,
        progressColors: const ProgressBarColors(
          playedColor: Color(0xff6C63FF),
          handleColor: Color(0xff6C63FF),
        ),
        // Default buffer spinner fills the player area; shrink it down.
        bufferIndicator: const Center(
          child: SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Color(0xff6C63FF),
            ),
          ),
        ),
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: const Color(0xffF5F5F7),
        appBar: AppBar(
          backgroundColor: const Color(0xffD6D6F5),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffD9D7F1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: player,
                ),
              ),
              if (widget.desc != null) ...[
                const SizedBox(height: 32),
                _HandDescription(desc: widget.desc!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HandDescription extends StatelessWidget {
  const _HandDescription({required this.desc});
  final LocalizedText desc;

  @override
  Widget build(BuildContext context) {
    final text = isArabic() ? desc.ar : desc.en;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                "Assets/images/hand description.png",
                width: 25,
                height: 25,
              ),
              const SizedBox(width: 8),
              Text(
                S.of(context).video_hand_description,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: const Color(0xffD6D6F5),
              ),
              color: const Color(0xffF2F2F2),
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  spreadRadius: 0.3,
                  color: Color(0xffADADEB),
                ),
              ],
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
