import 'package:flutter/material.dart';
import 'package:manafood/screens/signin.dart';
import 'package:manafood/screens/signup.dart';
import 'package:manafood/utility/my_style.dart';
import 'package:manafood/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_rider.dart';
import 'main_shop.dart';
import 'main_user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();
  }

  Future<Null> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String chooseType = preferences.getString('ChooseType');
      if (chooseType != null && chooseType.isNotEmpty) {
        if (chooseType == 'User') {
          routeToService(MainUser());
        } else if ((chooseType == 'Shop')) {
          routeToService(MainShop());
        } else if ((chooseType == 'Rider')) {
          routeToService(MainRider());
        } else {
          normalDialog(context, 'Error User Type');
        }
      } else {}
    } catch (e) {}
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          showHeadDrawer(),
          signInMenu(),
          signUpMenu(),
        ],
      ));

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(
        Icons.login,
      ),
      title: Text('Sign In'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
      leading: Icon(
        Icons.logout,
      ),
      title: Text('Sign Up'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignUp());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().myBoxDecoration('guest.jpg'),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: Text('Guest',style: TextStyle(color: Colors.blue)),
        accountEmail: Text('Please Login',style: TextStyle(color: Colors.blue)));
  }
}
