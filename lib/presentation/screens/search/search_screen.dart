import 'package:book_store/ui/theme/main_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/audio_bloc/audio_bloc.dart';
import '../../../bloc/search_bloc/search_bloc.dart';
import '../../../data/model/book_data.dart';
import '../../../ui/components/components.dart';
import '../../../ui/theme/light_colors.dart';
import '../book_viewer/audio_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        print("*****************************  screen after search  ${state.searched.length}");
        return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 25,),
                   searchField(),

                    const SizedBox(height: 35,),

                    state.searched.isEmpty
                        ? emptyField()
                        : ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => bookItem(state.searched[index]),
                        separatorBuilder: (context, index) => const SizedBox(height: 15,),
                        itemCount: state.searched.length
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

  Widget emptyField() {
    return Column(
      children: [

        const SizedBox(height: 100,),

        Center(
          child: Image.asset(
            MainImages.logo,
            height: MediaQuery.of(context).size.width / 2,
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ],
    );
  }

  Widget searchField() {
    return TextField(
      controller: _controller,
      maxLines: 1,
      maxLength: 20,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFF3F3F3),
        hintText: 'Enter text',
        hintStyle: TextStyle(color: Color(0xFF565656)),
        counterText: '', // Hide the counter text
        prefixIcon: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
          icon: Icon(Icons.cancel_outlined),
          onPressed: () {
            _controller.clear();
            setState(() {}); // Trigger a rebuild to hide the cancel icon
          },
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF26B6C)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF26B6C)),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: (text) {
        text.trim();
        if(text.trim().isNotEmpty) {
          context.read<SearchBloc>().add(Search(inputKey: text.trim()));
          setState(() {}); // Trigger a rebuild to show/hide the cancel icon
        }
      },
    );
  }
}
