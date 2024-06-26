import 'package:book_store/bloc/home_bloc/home_bloc.dart';
import 'package:book_store/bloc/library_bloc/library_bloc.dart';
import 'package:book_store/data/model/book_data.dart';
import 'package:book_store/presentation/screens/home/home_screen.dart';
import 'package:book_store/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/audio_bloc/audio_bloc.dart';
import '../../../ui/theme/light_colors.dart';
import '../../../ui/theme/main_images.dart';
import '../book_viewer/audio_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  @override
  void initState() {
    super.initState();

    context.read<LibraryBloc>().add(LibraryLoadBooks());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LibraryBloc, LibraryState>(
      listener: (context, state) {
        if(state.back) Navigator.pop(context, true);
        if(state.openHome) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => HomeBloc(), // Provide HomeBloc here
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) => const HomeScreen(),
                ),
              ),
            ),

          );
        }
      },
      builder: (context, state) {
        print("*******************************   library screen ${state.books.length}   *******************************");
        return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: myAppBar(
                  "Library", Colors.black, LightColors.primary, () {
                context.read<LibraryBloc>().add(LibraryBackEvent());
              }
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: myFloatingActionButton(),
              bottomNavigationBar: myBottomNavigation(),
              body: state.books.isEmpty
                ? Center(
                child: Image.asset(
                  MainImages.logo,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                ),
              )
                : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 25,),
                    categorySection(),
                    const SizedBox(height: 45,),
                    ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => bookItem(state.books[index]),
                      separatorBuilder: (context, index) => const SizedBox(height: 15,),
                      itemCount: state.books.length
                    )
                  ],
                ),
              ),
            )
        );
      },
    );
  }

  Widget bookItem(BookData book) {
    return GestureDetector(
      onTap: () {
        print("***********************  id ${book.id}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AudioBloc(),
              child: BlocBuilder<AudioBloc, AudioState>(
                builder: (context, state) => AudioScreen(bookData: book,),
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                MainImages.start,
                color: LightColors.primary,
                height: 14,
                width: 14,
              ),

              const SizedBox(width: 15,),

              SizedBox(
                height: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegularText(
                      text: book.bookName,
                      fontSize: 14,
                      color: LightColors.lightBlack,
                    ),

                    RegularText(
                      text: book.authorName,
                      fontSize: 12,
                      color: LightColors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20,),

          Container(
            width: double.infinity,
            height: 1,
            color: LightColors.grey.withAlpha(50),
          )
        ],
      ),
    );
  }

  Widget myFloatingActionButton() {
    return Container(
      height: 56,
      width: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: [

          ]
      ),
      child: Container(
        width: 46,
        height: 46,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: LightColors.primary,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          MainImages.play,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget myBottomNavigation() {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      shape: const CircularNotchedRectangle(),
      height: 60,
      color: Colors.grey.withAlpha(20),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          bottomBarIcon(Icons.home_filled, "Home", false, () {
            context.read<LibraryBloc>().add(LibraryHomeEvent());
          }),
          bottomBarIcon(Icons.search_sharp, "Search", false,() {}),
          bottomBarIcon(Icons.book, "Library", true, () {}),
          bottomBarIcon(Icons.person, "Profile", false, () {}),
        ],
      ),
    );
  }

  Widget bottomBarIcon(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? LightColors.primary : LightColors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          MediumText(
            text: label,
            fontSize: 11,
            color: isActive ? LightColors.primary : LightColors.grey,
          )
        ],
      ),
    );
  }

  Widget categorySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BoldText(
          text: "Bookmarks",
          fontSize: 20,
          color: Colors.black,
        ),

        BoldText(
          text: "See all",
          fontSize: 12,
          color: LightColors.primary,
        )
      ],
    );
  }
}
