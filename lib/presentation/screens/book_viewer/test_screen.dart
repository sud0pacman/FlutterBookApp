// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// class AudioPlayerScreen extends StatefulWidget {
//   final String url;
//
//   const AudioPlayerScreen({Key? key, required this.url}) : super(key: key);
//
//   @override
//   _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
// }
//
// class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
//   late AudioPlayer _audioPlayer;
//   late AudioCache _audioCache;
//   bool isPlaying = false;
//   bool isPaused = false;
//   Duration _duration = Duration();
//   Duration _position = Duration();
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     _audioCache = AudioCache(fixedPlayer: _audioPlayer);
//
//     _audioPlayer.onDurationChanged.listen((Duration d) {
//       setState(() => _duration = d);
//     });
//
//     _audioPlayer.onAudioPositionChanged.listen((Duration p) {
//       setState(() => _position = p);
//     });
//
//     _audioPlayer.onPlayerCompletion.listen((event) {
//       setState(() {
//         _position = Duration();
//         isPlaying = false;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   void _play() async {
//     int result = await _audioPlayer.play(widget.url);
//     if (result == 1) {
//       setState(() {
//         isPlaying = true;
//         isPaused = false;
//       });
//     }
//   }
//
//   void _pause() async {
//     int result = await _audioPlayer.pause();
//     if (result == 1) {
//       setState(() {
//         isPlaying = false;
//         isPaused = true;
//       });
//     }
//   }
//
//   void _stop() async {
//     int result = await _audioPlayer.stop();
//     if (result == 1) {
//       setState(() {
//         isPlaying = false;
//         isPaused = false;
//         _position = Duration();
//       });
//     }
//   }
//
//   String _formatDuration(Duration d) {
//     return d.toString().split('.').first;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Audio Player')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Audio URL: ${widget.url}'),
//             Slider(
//               value: _position.inSeconds.toDouble(),
//               min: 0.0,
//               max: _duration.inSeconds.toDouble(),
//               onChanged: (double value) {
//                 setState(() {
//                   _audioPlayer.seek(Duration(seconds: value.toInt()));
//                 });
//               },
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
//                   onPressed: isPlaying ? _pause : _play,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.stop),
//                   onPressed: _stop,
//                 ),
//               ],
//             ),
//             Text('${_formatDuration(_position)} / ${_formatDuration(_duration)}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
