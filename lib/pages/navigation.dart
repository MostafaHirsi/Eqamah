import 'package:eqamah/pages/event.dart';
import 'package:eqamah/pages/home.dart';
import 'package:eqamah/pages/info.dart';
import 'package:eqamah/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int tabIndex = 0;
  List<Widget> pages = [
    HomePage(),
    EventPage(),
    InformationPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: buildActions(),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: pages[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColor,
        onTap: (tappedIndex) {
          setState(() {
            tabIndex = tappedIndex;
          });
        },
        currentIndex: tabIndex,
        items: [
          buildBottomNavigationBarItem(Icons.home, "Home"),
          buildBottomNavigationBarItem(Icons.event, "Events"),
          buildBottomNavigationBarItem(Icons.info, "Info"),
          buildBottomNavigationBarItem(Icons.settings, "Settings"),
        ],
      ),
    );
  }

  List<Widget> buildActions() {
    // switch(){
    //   case "Home":
       
    //   break;
    //   case 2:
    //   break;
    //   case 3:
    //   break;
    //   }
    // }
    return <Widget>[
        tabIndex != 2 ?  IconButton(
          icon: Icon(
            FontAwesomeIcons.mosque,
          ),
          onPressed: () {},
        ) : Container()
      ];
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      IconData icon, String label) {
    double bottomPadding = 3.0;
    return BottomNavigationBarItem(
      backgroundColor: Theme.of(context).primaryColor,
      icon: Container(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: Color(0xFF009000),
            ),
            Text(
              label,
              style: TextStyle(color: Color(0xFF009000)),
            ),
          ],
        ),
      ),
      title: Container(),
      activeIcon: Container(
        padding: EdgeInsets.only(bottom: bottomPadding),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF009000),
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: Color(0xFF009000),
            ),
            Text(
              label,
              style: TextStyle(color: Color(0xFF009000)),
            ),
          ],
        ),
      ),
    );
  }
}
