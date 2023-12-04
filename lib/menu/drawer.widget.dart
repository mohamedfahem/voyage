import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/global.params.dart';

class MyDrawer extends StatelessWidget {
  late SharedPreferences prefs;

  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white, Colors.blue]),
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("images/profil.png"),
                radius: 80,
              ),
            ),
          ),
          ...((GlobalParams.menus as List).map((item) {
            return Column(
              children: [
                ListTile(
                  title: Text(item['title'] as String,
                      style: TextStyle(fontSize: 22)),
                  leading: item['icon'] as Icon,
                  trailing: Icon(Icons.arrow_right, color: Colors.blue),
                  onTap: () async {
                    if (item['title'] != "Déconnexion") {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, item['route'] as String);
                    } else {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/authentification', (Route<dynamic> route) => false);
                    }
                  },
                ),
                Divider(height: 4, color: Colors.blue),
              ],
            );
          })),
        ],
      ),
    );
  }
}
