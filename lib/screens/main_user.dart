import 'package:flutter/material.dart';
import 'package:manafood/utility/my_style.dart';
import 'package:manafood/utility/signout_process.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String nameUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser == null ? 'Main User' : '$nameUser login'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => signOutProcess(context))
        ],
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
          ],
        ),
      );
}

UserAccountsDrawerHeader showHead() {
  return UserAccountsDrawerHeader(
    decoration: MyStyle().myBoxDecoration('user.jpg'),
    currentAccountPicture: MyStyle().showLogo(),
    accountName: Text(
      'Nane Login',
      style: TextStyle(color: MyStyle().darkColor),
    ),
    accountEmail: Text(
      'Login',
      style: TextStyle(color: MyStyle().primaryColor),
    ),
  );
}
