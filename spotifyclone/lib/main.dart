import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(SpotifyUI());
}

class SpotifyUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SpotifyScreen(),
    );
  }
}

class SpotifyScreen extends StatefulWidget {
  @override
  _SpotifyScreenState createState() => _SpotifyScreenState();
}

class _SpotifyScreenState extends State<SpotifyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isPlaying = false;
  Duration duration = Duration(seconds: 170); // Example song duration
  Duration position = Duration.zero;
  late Ticker _ticker;
  bool isLiked = false; // Track like status
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _ticker = Ticker((elapsed) {
      if (isPlaying) {
        setState(() {
          position += Duration(milliseconds: 16); // Update position
          if (position >= duration) {
            isPlaying = false;
            _controller.reverse();
            _ticker.stop();
          }
        });
      }
    });

    _audioPlayer = AudioPlayer();
    _audioPlayer.setSource(AssetSource('assets/song.mp3'));
  }

  @override
  void dispose() {
    _controller.dispose();
    _ticker.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    setState(() {
      if (isPlaying) {
        _controller.reverse();
        _ticker.stop();
        _audioPlayer.pause();
      } else {
        _controller.forward();
        _ticker.start();
        _audioPlayer.resume();
      }
      isPlaying = !isPlaying;
    });
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked; // Toggle the liked status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spotify clone',
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
            Text(
              'This Is Arijit Singh',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Icon(Icons.more_vert),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/arjith.jpeg', // Replace with your image
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft, // Aligns the text to the left
                    child: Text(
                      'Sajni',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Arijit Singh, Ram Sampath, Prashant Pandey',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70),
                      ),
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.white70,
                        ),
                        onPressed: _toggleLike,
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Slider(
                    value: position.inSeconds.toDouble(),
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        position = Duration(seconds: value.toInt());
                        _audioPlayer.seek(position); // Seek to new position
                      });
                    },
                    activeColor: Colors.white,
                    inactiveColor: Colors.white24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(position),
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          _formatDuration(duration),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.shuffle),
                        iconSize: 28,
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.skip_previous),
                        iconSize: 40,
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        iconSize: 64,
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: _controller,
                        ),
                        onPressed: _playPause,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.skip_next),
                        iconSize: 40,
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.repeat),
                        iconSize: 28,
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Text(
              'Lyrics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
