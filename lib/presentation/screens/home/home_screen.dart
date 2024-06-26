import 'package:book_store/bloc/audio_bloc/audio_bloc.dart';
import 'package:book_store/bloc/home_bloc/home_bloc.dart';
import 'package:book_store/bloc/library_bloc/library_bloc.dart';
import 'package:book_store/data/model/book_data.dart';
import 'package:book_store/presentation/screens/book_viewer/audio_screen.dart';
import 'package:book_store/presentation/screens/library/library_screen.dart';
import 'package:book_store/ui/components/components.dart';
import 'package:book_store/ui/theme/light_colors.dart';
import 'package:book_store/ui/theme/main_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/search_bloc/search_bloc.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Color> colors = [
    LightColors.primary, Color(0xff219653), Color(0xffF2C94C), Color(0xff2F80ED),
    LightColors.primary, Color(0xff219653), Color(0xffF2C94C), Color(0xff2F80ED),
    LightColors.primary, Color(0xff219653),
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(LoadBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        print("*************************************  ${state}");
        if (state.openLibrary) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => LibraryBloc(),
                child: BlocBuilder<LibraryBloc, LibraryState>(
                  builder: (context, state) => const LibraryScreen(),
                ),
              ),
            ),
          );
        } else if (state.openSearch) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => SearchBloc(),
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) => const SearchScreen(),
                ),
              ),
            ),
          );
        } else if (state.back) {
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        // print("************************ my screen ${state.books.length} ************************");
        return SafeArea(
          child: Scaffold(
            appBar: myAppBar(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: myFloatingActionButton(),
            bottomNavigationBar: myBottomNavigation(),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 0,),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: state.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      var cutIndex = state.categories.elementAt(index).indexOf(",");
                      cutIndex = cutIndex == -1 ? state.categories.elementAt(index).length : cutIndex;
                      var categoryName = state.categories.elementAt(index).substring(0, cutIndex);
                      return categoryWidget(categoryName, colors[index % 10], index, index == selectedIndex);
                    },
                  ),
                ),

                const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: state.books.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns
                      crossAxisSpacing: 15.0, // Horizontal spacing between columns
                      mainAxisSpacing: 15.0, // Vertical spacing between rows
                      childAspectRatio: 0.7, // Aspect ratio of each item
                    ),
                    itemBuilder: (context, index) => bookItem(state.books[index]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
          bottomBarIcon(Icons.home_filled, "Home", true, () {}),

          bottomBarIcon(Icons.search_sharp, "Search", false, () {
            myToast("search");
            print("************************* click Search");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => SearchBloc(),
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) => const SearchScreen(),
                  ),
                ),
              ),
            );
          }),


          bottomBarIcon(Icons.book, "Library", false, () {
            myToast("library");
            print("************************* click Library");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => LibraryBloc(),
                  child: BlocBuilder<LibraryBloc, LibraryState>(
                    builder: (context, state) => const LibraryScreen(),
                  ),
                ),
              ),
            );
          }),

          bottomBarIcon(Icons.person, "Profile", false, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }),
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

  Widget myFloatingActionButton() {
    return Container(
      height: 56,
      width: 56,
      alignment: Alignment.center,
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


  Widget bookItem(BookData book) {
    return InkWell(
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
      child: Container(
        width: MediaQuery.of(context).size.width * .3,
        height: 146,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(book.imgUrl),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(4, 8), // Shadow position
            ),
          ]
        ),
      ),
    );
  }

  Widget categoryWidget(
      String text,
      Color color,
      int index,
      bool isSelect,
  ) {
    return InkWell(
      onTap: () {
        selectedIndex = index;
        context.read<HomeBloc>().add(HomeFilterEvent(category: text));
        setState(() {});
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 35),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 2, color: isSelect ? color : Colors.transparent)
        ),
        child: BoldText(
          text: text,
          color: color,
          fontSize: 12,
        ),
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            MainImages.back,
            width: 24,
            height: 24,
            color: LightColors.black,
          ),

          BoldText(
            text: "Explore",
            color: LightColors.primary,
          ),

          const Icon(
            Icons.more_vert,
            size: 24,
            color: LightColors.black,
          )
        ],
      ),
    );
  }
}
