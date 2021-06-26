import 'package:flutter/material.dart';
import 'package:tugas1/login/auth.dart';

class Menudrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //widget drawer
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            //bagian header pada drawer
            accountName: Text("ABCD"),
            accountEmail: Text("abcd@gmail.com"),
            currentAccountPicture: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.canbind.ca/wp-content/uploads/2018/04/blank-profile-picture-973460_640-300x300.png"),
              ),
            ),
            decoration: BoxDecoration(color: Colors.deepPurple), // mewarnai background drawer
          ),
          ListTile(
            //widget untuk drawer di bagian list tilenya
            title: Text("Profile"),
            trailing: Icon(Icons.account_circle),
          ),
          ListTile(
            title: Text("Settings"),
            trailing: Icon(Icons.settings),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
            child: ListTile(
              title: Text("Log Out"),
              trailing: Icon(Icons.logout),
            ),
          )
        ],
      ),
    );
  }
}
