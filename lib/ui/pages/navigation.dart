import 'package:eqamah/bloc/home_bloc.dart';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:eqamah/ui/pages/event.dart';
import 'package:eqamah/ui/pages/home.dart';
import 'package:eqamah/ui/pages/info.dart';
import 'package:eqamah/ui/pages/mosques.dart';
import 'package:eqamah/ui/pages/settings.dart';
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

    prayerTimeBloc.fetchAllPrayers();

    return Scaffold(
      appBar: tabIndex != 2 && tabIndex != 0
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              actions: buildActions(),
            )
          : null,
      backgroundColor: Theme.of(context).primaryColor,
      body: StreamBuilder(
        stream: prayerTimeBloc.allPrayers,
        builder: (context, AsyncSnapshot<DashboardMosqueModel> snapshot) {
          if (snapshot.hasData) {
            return pages[tabIndex];
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
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
      tabIndex == 0 || tabIndex == 3
          ? IconButton(
              icon: Icon(
                FontAwesomeIcons.mosque,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MosquesPage()));
              },
            )
          : Container(),
      tabIndex == 1
          ? IconButton(
              icon: Icon(
                Icons.tune,
                size: 30.0,
              ),
              onPressed: () {},
            )
          : Container()
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
              color: Colors.white,
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
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
              color: Colors.white,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
