import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/pages/home.dart';
import 'package:shoppingapp/pages/orders.dart';
import 'package:shoppingapp/pages/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget>pages;
  // ignore: non_constant_identifier_names
  late Home MyHomePage;
  late Orders order;
  late Profile profile;
  int currentTabIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    MyHomePage=Home();
    order=Orders();
    profile=Profile();    
    pages=[MyHomePage,order,profile];
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Color.fromARGB(255, 217, 216, 220),
        color: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        onTap: (int index){
          setState(() {
            currentTabIndex=index;
          });
        },
        items: [
        Icon(Icons.home_outlined,
        color: Colors.white,),
        Icon(Icons.shopping_bag_outlined,
        color: Colors.white,),
        Icon(Icons.person,
        color: Colors.white,),
      ],),
      body: pages[currentTabIndex],
    );
  }
}