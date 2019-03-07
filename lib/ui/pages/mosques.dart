import 'package:eqamah/ui/controls/demo.dart';
import 'package:flutter/material.dart';

class MosquesPage extends StatefulWidget {
  @override
  _MosquesPageState createState() => _MosquesPageState();
}

class _MosquesPageState extends State<MosquesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mosques'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              // Flexible(
              //   flex: 50,
              //   child: Container(
              //     color: Colors.black,
              //   ),
              // ),
              Flexible(
                flex: 50,
                child: Container(
                  child: MapsPage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
