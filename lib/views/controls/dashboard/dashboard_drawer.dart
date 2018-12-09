import 'package:eqamah/views/pages/demo_map.dart';
import 'package:eqamah/views/pages/mapview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardDrawer extends StatelessWidget {
  DashboardDrawer({
    Key key,
  }) : super(key: key);

  List<Widget> drawerItems;

  @override
  Widget build(BuildContext context) {
    buildDrawer(context);
    return new Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: drawerItems,
      ),
    );
  }

  void buildDrawer(BuildContext context) {
    drawerItems = [];
    drawerItems.add(new MainDrawerHeader());
    dynamic profileTap = () {
      Navigator.pop(context);
    };
    dynamic mapTap = () {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext buildcontext) => new MapsDemo()));
    };
    drawerItems.add(new DrawerItem(
        icon: Icons.people, tileTitle: "Profile", onTap: profileTap));
    drawerItems.add(new DrawerItem(
        icon: Icons.map, tileTitle: "Mosques", onTap: mapTap));
    drawerItems.add(new DrawerItem(
        icon: Icons.settings, tileTitle: "Settings", onTap: profileTap));
  }
}

class MainDrawerHeader extends StatelessWidget {
  const MainDrawerHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: new Center(
        child: Container(
          padding: EdgeInsets.all(2.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new CircleAvatar(
                minRadius: 50.0,
                child: new Icon(
                  Icons.person,
                  size: 70.0,
                  color: Colors.white,
                ),
              ),
              new Text(
                'Mostafa Hirsi',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: new Color(0xFFf8653c),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key key,
    @required IconData icon,
    @required String tileTitle,
    @required this.onTap,
  })  : _icon = icon,
        _tileTitle = tileTitle,
        super(key: key);

  final IconData _icon;
  final String _tileTitle;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: ListTile(
        leading: Icon(_icon),
        title: Text(_tileTitle),
        onTap: onTap,
        // trailing: CircleAvatar(
        //   radius: 10.0,
        //   child: Text(
        //     "2",
        //     style: TextStyle(color: Colors.white, fontSize: 12.0),
        //   ),
        // ),
      ),
    );
  }
}
