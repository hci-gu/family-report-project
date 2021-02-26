import 'package:flutter/material.dart';

class RegularGreenButton extends StatelessWidget {
  final String buttonText;
  final Function buttonOnClick;
  RegularGreenButton(this.buttonText, this.buttonOnClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30),
      child: ElevatedButton(
        onPressed: buttonOnClick,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 16),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
