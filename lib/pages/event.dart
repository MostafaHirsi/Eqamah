import 'package:eqamah/views/pages/eventDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}


class _EventPageState extends State<EventPage> {
  // Add Database information into the arrays below 
  List <String> eventItems = ["This is the first page", "Second Page", "wewe"];
  List <String> eventNames = ["Charity Run", "Janazah", "wewe"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("Events"),
        actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.tune),
            onPressed: () => Navigator.of(context).pop(null),
           ),
         ],
         
      ),
      backgroundColor: Colors.blue,
      body:ListView.builder(itemBuilder: buildEventItem, itemCount: eventItems.length,)
    );
  }
  
  Widget buildEventItem(BuildContext context, int index){
    String eventItem = eventItems[index];
    String eventName = eventNames[index];
    return new EventItem(eventId: eventItem, eventListName: eventName,);
  }
}


class EventItem extends StatelessWidget {
  final String eventId;
  final String eventListName;
  const EventItem({
    Key key, @required this.eventId,
    Key key1, @required this.eventListName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.grey))),
          child: Icon(Icons.calendar_today, color: Colors.black),

        ),
      title: Text(eventListName),
       subtitle: Row(
          children: <Widget>[
            Text(" Place holder Text", style: TextStyle(color: Colors.black))
          ],
        ),
          trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
      onTap: () {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MosqueEventDetailPage(eventId: eventId, eventListName: eventListName,)));
    },
    );
  }
}

