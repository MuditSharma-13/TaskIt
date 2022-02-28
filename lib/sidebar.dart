import 'package:flutter/material.dart';
import 'package:nudger/pages/about_us.dart';
import 'package:nudger/pages/home.dart';
import 'package:nudger/pages/contact_us.dart';
import 'package:nudger/sidebar_item.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
          color: Colors.amber[200],
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 200,
                  width: 310,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hello!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' Hope you finish your tasks 👍',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // Divider(
                //   thickness: 2,
                //   height: 20,
                //   color: Colors.grey,
                // ),
                SideBarItem(
                    name: 'Home',
                    icon: Icons.home,
                    onPressed: () => onItemPressed(context, index: 0)),
                SideBarItem(
                  name: 'About Us',
                  icon: Icons.people,
                  onPressed: () => onItemPressed(context, index: 1),
                ),
                SideBarItem(
                  name: 'Contact Us',
                  icon: Icons.phone,
                  onPressed: () => onItemPressed(context, index: 2),
                ),
                SizedBox(
                  height: 30,
                ),
              ])),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CategoriesScreen()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutUs()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ContactUs()));
        break;
    }
  }

  Widget header() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
        )
      ],
    );
  }
}
