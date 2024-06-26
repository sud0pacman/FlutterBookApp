import 'package:book_store/bloc/audio_bloc/audio_bloc.dart';
import 'package:book_store/data/model/book_data.dart';
import 'package:book_store/ui/theme/light_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../ui/components/components.dart';
import '../../../ui/theme/main_images.dart';

class AudioScreen extends StatefulWidget {
  final BookData bookData;
  const AudioScreen({super.key, required this.bookData});

  @override
  State<AudioScreen> createState() => _AudioScreenState(book: bookData);
}

class _AudioScreenState extends State<AudioScreen> {
  final BookData book;

  bool isStart = false;

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  _AudioScreenState({required this.book});


  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }


  Future<void> setAudio() async{
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    String url = book.audioUrl;
    audioPlayer.setSourceUrl(url);
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AudioBloc, AudioState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: -MediaQuery.of(context).size.height / 2,
                    left: 0,
                    right: 0,
                    child: myCircle(
                      MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.height
                    )
                  ),
                  Positioned(
                      child: Column(
                        children: [
                          myAppBar("Now Playing"),
                          const SizedBox(height: 25,),
                          infoSection(book),
                          musicSection()
                        ],
                      )
                  )
                ],
              ),
            ),
          );
        },
    );
  }
  
  Widget musicSection() {
    return Column(
      children: [
        Slider(
          min: 0,
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(),
          activeColor: LightColors.primary,
          inactiveColor: LightColors.grey,
          thumbColor: LightColors.primary,
          onChanged: (value) async {
            final position = Duration(seconds: value.toInt());
            await audioPlayer.seek(position);
            await audioPlayer.resume();
          }
        ),

        const SizedBox(height: 15,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularText(text: timeFormatter(position)),
              RegularText(text: timeFormatter(duration - position)),
            ],
          ),
        ),

        controllerButton()
      ],
    );
  }

  Widget controllerButton() {
    return InkWell(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async{
        if(isPlaying) {
          await audioPlayer.pause();
        }
        else {
          await audioPlayer.resume();
        }
      },
      child: Container(
        height: 52,
        width: 52,
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: LightColors.primary.withAlpha(30),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          isPlaying ? MainImages.pause : MainImages.play,
          color: LightColors.primary,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  String timeFormatter(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if(duration.inHours > 0) hours,
      minutes,
      seconds
    ].join(",");
  }

  Widget infoSection(BookData book) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        myImg(book.imgUrl),
        const SizedBox(height: 35,),
        RegularText(text: book.bookName),
        const SizedBox(height: 15,),
        BoldText(text: book.authorName, fontSize: 12,),
      ],
    );
  }

  Widget myImg(String imgUrl) {
    var width = MediaQuery.of(context).size.width / 2;
    return Container(
      width: width,
      height: width + (width / 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imgUrl,),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ]
      ),
    );
  }

  AppBar myAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            MainImages.back,
            width: 24,
            height: 24,
            color: Colors.white,
          ),

          BoldText(
            text: title,
            color: Colors.white,
          ),

          const Icon(
            Icons.more_vert,
            size: 24,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget myCircle(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: LightColors.primary,
        shape: BoxShape.circle
      ),
    );
  }
}
