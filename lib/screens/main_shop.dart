import 'package:flutter/material.dart';
import 'package:manafood/utility/my_style.dart';
import 'package:manafood/utility/signout_process.dart';
import 'package:manafood/widget/infomation_shop.dart';
import 'package:manafood/widget/list_food_manu_shop.dart';
import 'package:manafood/widget/order_list_shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  String nameUser;
  //Fielding
  Widget currentWidget = OrderListShop();
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
        title: Text('Main Shop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOutProcess(context),
          )
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            homeMenu(),
            foodMenu(),
            informationMenu(),
            signOutMenu(),
          ],
        ),
      );
  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text('รายการอาหารที่ลูกค้าสั่ง'),
        subtitle: Text('รายการอาหารที่ยังไม่ได้ ทำส่ง'),
        onTap: () {
          setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );
  ListTile foodMenu() => ListTile(
        leading: Icon(Icons.fastfood),
        title: Text('รายการอาหาร'),
        subtitle: Text('รายการอาหารของร้าน'),
        onTap: () {
          setState(() {
            currentWidget = ListFoodMenuShop();
          });
          Navigator.pop(context);
        },
      );
  ListTile informationMenu() => ListTile(
        leading: Icon(Icons.details),
        title: Text('รายละเอียดของร้าน'),
        subtitle: Text('รายละเอียดของร้านพร้อมแก้ไข'),
        onTap: () {
          setState(() {
            currentWidget = InfomationShop();
          });
          Navigator.pop(context);
        },
      );
  ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        subtitle: Text('Sign Out แล้วกลับไปหน้าแรก'),
        onTap: () => signOutProcess(context),
      );
  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('shop.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(
        'Name Login',
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        'Login',
        style: TextStyle(color: MyStyle().primaryColor),
      ),
    );
  }
}
