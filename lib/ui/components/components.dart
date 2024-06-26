import 'package:book_store/ui/theme/light_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BoldText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const BoldText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color = LightColors.grey
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: "UniBold",
        height: .1
      ),
    );
  }
}


class RegularText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const RegularText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color = LightColors.grey
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: "UniRegular",
          height: .1
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const CustomTextField({
    super.key,
    required this.controller,
    this.hint = "Email Address"
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontFamily: "UniRegular"
      ),
      decoration:  InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: "UniRegular",
          color: Color(0xFF787878),
          fontSize: 14.0,
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF2F2F2),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF2F2F2),
          ),
        ),
      ),
      controller: controller,
    );
  }
}

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController myController;
  final String hint;

  const CustomPasswordTextField({
    super.key,
    required this.myController,
    this.hint = "Password"
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontFamily: "UniRegular"
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF787878),
          fontSize: 14.0,
            fontFamily: "UniRegular"
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF2F2F2),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF2F2F2),
          ),
        ),
      ),
      controller: myController,
    );
  }
}

class MyMainButton extends StatelessWidget {
  final String text;
  final double height;
  final double borderRadius;
  final VoidCallback onClick;

  const MyMainButton({
    Key? key,
    required this.text,
    this.height = 43,
    this.borderRadius = 22,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2;

    return InkWell(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: LightColors.primary, // Use your LightColors.primary here
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        child: Center(
          child: BoldText(
            text: text,
            color: Colors.white,
            fontSize: 14,
          )
        ),
      ),
    );
  }
}

class TextWithSpan extends StatelessWidget {
  final String mainText;
  final String innerText;
  final VoidCallback onTap;

  const TextWithSpan({super.key, required this.mainText, required this.innerText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: mainText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: "UniRegular"
          ),
          children: [
            TextSpan(
              text: innerText,
              style: const TextStyle(
                  color: LightColors.redText,
                  fontSize: 14,
                  fontFamily: "UniRegular"
              ),
            )
          ]
        )
      ),
    );
  }
}

Future<bool?> myToast(String message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


