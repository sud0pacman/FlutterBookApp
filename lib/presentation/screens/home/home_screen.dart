import 'package:book_store/bloc/home_bloc/home_bloc.dart';
import 'package:book_store/data/model/book_data.dart';
import 'package:book_store/ui/components/components.dart';
import 'package:book_store/ui/theme/light_colors.dart';
import 'package:book_store/ui/theme/main_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../book_viewer/pdf_screen.dart';

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

  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(LoadBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          Set<String> categories = {};

          for(var book in state.books) {
            categories.add(book.category);
          }

          print("************************ my screen ${state.books.length} ************************");
          return SafeArea(
            child: Scaffold(
              appBar: myAppBar(),
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 0,),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        var cutIndex = categories.elementAt(index).indexOf(",");
                        cutIndex = cutIndex == -1 ? categories.elementAt(index).length : cutIndex;
                        var categoryName = categories.elementAt(index).substring(0, cutIndex);
                        return categoryWidget(categoryName, colors[index % 10]);
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
                  )

                ],
              ),
            )
          );
        }
    );
  }

  Widget bookItem(BookData book) {
    return InkWell(
      onTap: () {
        print("***********************  url ${book.pdfUrl}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFScreen(url: book.pdfUrl),
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
          )
        ),
      ),
    );
  }

  Widget categoryWidget(
      String text,
      Color color,
  ) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 35),
      alignment: Alignment.center,
      color: color.withAlpha(30),
      child: BoldText(
        text: text,
        color: color,
        fontSize: 12,
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
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
