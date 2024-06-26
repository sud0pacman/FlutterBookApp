import 'package:book_store/bloc/audio_bloc/audio_bloc.dart';
import 'package:book_store/data/local/my_pref.dart';
import 'package:book_store/data/model/book_data.dart';
import 'package:book_store/presentation/screens/pdf_viewer/pdf_screen.dart';
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

  final SharedPreferencesHelper _pref = SharedPreferencesHelper();

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  ReleaseMode mode = ReleaseMode.stop;

  _AudioScreenState({required this.book});


  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
    audioPlayer.release();
  }

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
    audioPlayer.setReleaseMode(mode);
    String url = book.audioUrl;
    audioPlayer.setSourceUrl(url);
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AudioBloc, AudioState>(
        listener: (context, state) {
          if(state.back) Navigator.pop(context, true);
        },
        builder: (context, state) {
          return Scaffold(
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
                        const SizedBox(height: 35,),
                        infoSection(book),
                        const SizedBox(height: 35,),
                        musicSection(),
                        const SizedBox(height: 35,),
                        audioStatusSection()
                      ],
                    )
                )
              ],
            ),
          );
        },
    );
  }

  Widget audioStatusSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          nightBtn(),
          const SizedBox(width: 15,),
          replayBtn(),
          const SizedBox(width: 15,),
          bookMarkBtn()
        ],
      ),
    );
  }

  Widget replayBtn() {
    return InkWell(
      onTap: () async{

        mode = mode == ReleaseMode.stop ? ReleaseMode.loop : ReleaseMode.stop;
        await audioPlayer.setReleaseMode(mode);

        setState(() {
        });
      },
      child: Container(
        height: 52,
        width: 52,
        padding: const EdgeInsets.all(17),
        child: Image.asset(
          MainImages.replay,
          color: mode == ReleaseMode.stop ? LightColors.grey : LightColors.primary,
        ),
      ),
    );
  }

  Widget bookMarkBtn() {
    var bookMarkStatus = _pref.getString(book.id);
    return InkWell(
      onTap: () async{
        bookMarkStatus ??= "";

        if(bookMarkStatus!.isNotEmpty) {
          await _pref.setString(book.id, "");
        }
        else {
          await _pref.setString(book.id, book.id);
        }

        print("*********************************  bookmark status $bookMarkStatus");

        setState(() {
        });
      },
      child: Container(
        height: 52,
        width: 52,
        padding: const EdgeInsets.all(17),
        child: Image.asset(
            MainImages.bookmark,
            color: bookMarkStatus == null || bookMarkStatus.isEmpty
                ? LightColors.grey
                : LightColors.primary),
      ),
    );
  }

  Widget nightBtn() {
    return Container(
      height: 52,
      width: 52,
      padding: const EdgeInsets.all(17),
      child: Image.asset(
        MainImages.night,
      ),
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

        const SizedBox(height: 30,),
        controllerButton()
      ],
    );
  }

  Widget controllerButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          seekToLeft(5),
          pauseStop(),
          seekToRight(5)
        ],
      ),
    );
  }

  Widget seekToRight(
      int second
    ) {
    return InkWell(
      onTap: () {
        setState(() {
          position += Duration(seconds: second);
          audioPlayer.seek(position);
        });
      },
      child: Container(
        height: 52,
        width: 52,
        padding: const EdgeInsets.all(15),
        child: Image.asset(
          MainImages.rightController,
        ),
      ),
    );
  }

  Widget seekToLeft(
    int second
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          if(position - Duration(seconds: second) < Duration.zero) return;
          position -= Duration(seconds: second);
          audioPlayer.seek(position);
        });
      },
      child: Container(
        height: 52,
        width: 52,
        padding: const EdgeInsets.all(15),
        child: Image.asset(
          MainImages.leftController,
          height: 14,
          width: 20,
        ),
      ),
    );
  }

  Widget pauseStop() {
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
        padding: const EdgeInsets.all(15),
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
    return InkWell(
      onTap: () {
        print("***********************  pdf url ${book.pdfUrl}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFScreen(url: book.pdfUrl,),
          ),
        );
      },
      child: Container(
        width: width,
        height: width + (width / 3),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
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
      ),
    );
  }

  AppBar myAppBar(String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              context.read<AudioBloc>().add(BackEvent());
            },
            child: Image.asset(
              MainImages.back,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
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
