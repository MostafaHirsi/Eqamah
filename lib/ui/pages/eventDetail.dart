import 'package:eqamah/ui/controls/mosque_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MosqueEventDetailPage extends StatefulWidget {
  final String eventId;
  final String eventListName;
  const MosqueEventDetailPage({
    Key key,
    this.eventId,
    String eName,
    this.eventListName,
  }) : super(key: key);
  @override
  _MosqueEventDetailPageState createState() =>
      _MosqueEventDetailPageState(eventId, eventListName);
}

class _MosqueEventDetailPageState extends State<MosqueEventDetailPage> {
  final String eventId;
  final String eventListName;
  final String bannerTitle = "Janazah";
  final String bannerImg =
      "https://i0.wp.com/muslimmemo.com/wp-content/uploads/2015/07/prophet-muhammad-hadith-10.png?zoom=1.25&w=501&h=314&ssl=1";
  _MosqueEventDetailPageState(this.eventId, this.eventListName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text(eventListName),
          ),
      body: Flex(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        direction: Axis.vertical,
        children: <Widget>[
          // Text(eventId),
          new MosqueBanner(bannerTitle: bannerTitle, bannerImg: bannerImg),
          new Card(
              margin: EdgeInsets.all(15.0),
              elevation: 0.0,
              child: Column(children: <Widget>[Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  Text(
                    eventListName,
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ), Icon(Icons.map, color: Colors.black, size: 35,)
                ], 
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[ Padding(padding: EdgeInsets.only(top:150) ,),
                  Icon(Icons.watch_later, color: Colors.black, size: 30,), Padding(padding: EdgeInsets.only(right: 50),),
                  Text("10:20", style: TextStyle(color: Colors.black, fontSize: 22),
                  )
                ],
              ),
             ],)),
        ],
      ),
    );
  }
}
