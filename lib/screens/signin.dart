import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manafood/model/user_model.dart';
import 'package:manafood/screens/main_rider.dart';
import 'package:manafood/screens/main_user.dart';
import 'package:manafood/utility/my_style.dart';
import 'package:manafood/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_shop.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String user, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[Colors.white, MyStyle().primaryColor],
              center: Alignment(0, -0.3),
              radius: 1.0,
            ),
          ),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showLogo(),
                MyStyle().mySizebox(),
                MyStyle().showTitle('Mana Food'),
                MyStyle().mySizebox(),
                userForm(),
                MyStyle().mySizebox(),
                passwordForm(),
                MyStyle().mySizebox(),
                loginButton()
              ],
            ),
          )),
        ));
  }

  Widget loginButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: MyStyle().darkColor,
          onPressed: () {
            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'กรุณาใส่่ข้อมูลให้ครบ');
            } else {
              checkAuthen();
            }
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
  Future<Null> checkAuthen() async {
    String url =
        'http://10.0.3.2/manafood/getUserWhereUser.php?isAdd=true&user=$user';
    try {
      Response response = await Dio().get(url);
      print('res=$response');
      var result = json.decode(response.data);
      print('result=$result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String chooseType = userModel.chooseType;
          print('chooseType=$chooseType');
          if (chooseType == 'User') {
            routeTuService(MainUser(), userModel);
          } else if (chooseType == 'Shop') {
            routeTuService(MainShop(), userModel);
          } else if (chooseType == 'Rider') {
            routeTuService(MainRider(), userModel);
          } else {
            normalDialog(context, 'Error');
          }
        } else {
          normalDialog(context, 'password ไม่ถูกต้อง');
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTuService(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('ChooseType', userModel.chooseType);
    preferences.setString('Name', userModel.name);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
            onChanged: (value) => user = value.trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
                color: MyStyle().darkColor,
              ),
              labelStyle: TextStyle(color: MyStyle().darkColor),
              labelText: 'User:',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().darkColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().primaryColor)),
            )),
      );
  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
            onChanged: (value) => password = value.trim(),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: MyStyle().darkColor,
              ),
              labelStyle: TextStyle(color: MyStyle().darkColor),
              labelText: 'Password:',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().darkColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().primaryColor)),
            )),
      );
}
