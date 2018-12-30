import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MosqueEventDetailPage extends StatefulWidget {
  final String eventId;
  final String eventListName;
  const MosqueEventDetailPage({Key key, this.eventId, String eName , this.eventListName,}) : super(key: key);
  @override
  _MosqueEventDetailPageState createState() => _MosqueEventDetailPageState(eventId, eventListName);
}

class _MosqueEventDetailPageState extends State<MosqueEventDetailPage> {
  final String eventId;
  final String eventListName;
  _MosqueEventDetailPageState(this.eventId, this.eventListName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
  
        direction: Axis.vertical,
        children: <Widget>[Text(eventId)],
      ),
    );
  }
}
