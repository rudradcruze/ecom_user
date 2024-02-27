import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {

  const WelcomeButton({super.key, required this.buttonText, required this.routeName, required this.backgroundColor, required this.textColor});
  final String buttonText;
  final String routeName;
  final Color backgroundColor;
  final Color textColor;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
          )
        ),
        child: Text(
          buttonText.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
