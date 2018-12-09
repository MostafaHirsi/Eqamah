import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StandardTextField extends StatelessWidget {
  StandardTextField(
      {Key key,
      @required this.userNameHint,
      @required this.icon,
      @required this.controller,
      @required this.obscureText,
      @required this.errorText})
      : super(key: key);

  String userNameHint;
  Icon icon = Icon(Icons.verified_user, color: Colors.white70);
  TextEditingController controller;
  String errorText;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new ShapeDecoration(
          color: new Color(0x99191919),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          )),
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
      height: 45.0,
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white70),
          icon: icon,
          errorStyle: TextStyle(color: Colors.white, fontSize: 17.0),
        ),
        style: TextStyle(height: 1.0, fontSize: 19.0),
        validator: (value) {
          if (value.isEmpty) {
            return errorText + "   ";
          }
          return "";
        },
        autovalidate: true,
        textAlign: TextAlign.center,
        controller: controller,
      ),
    );
  }
}
