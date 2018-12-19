import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MosqueInformationPage extends StatefulWidget {
  @override
  _MosqueInformationPageState createState() => _MosqueInformationPageState();
}

class _MosqueInformationPageState extends State<MosqueInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[],
      ),
    );
  }
}
