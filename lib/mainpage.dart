import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hlmobile/data/sharepre.dart';
import 'package:hlmobile/model/user.dart';
import 'package:hlmobile/page/category/categorywidget.dart';
import 'package:hlmobile/page/defaultwidget.dart';
import 'package:hlmobile/page/detail.dart';
import 'package:hlmobile/page/home.dart';
import 'package:hlmobile/page/product/productwidget.dart';
import 'package:hlmobile/route/page1.dart';
import 'package:hlmobile/route/page2.dart';
import 'package:hlmobile/route/page3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  User user = User.userEmpty();
  int _selectedIndex=0;

  getDataUser() async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    String strUser=pref.getString('user')!;

    user=User.fromJson(jsonDecode(strUser));
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
    print(user.imageURL);
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  _loadWidget(int index){
    var nameWidgets="Home";
    switch(index){
      case 0:{
        return const Product();
      }
      case 1:
        nameWidgets="Contact";
        break;
      case 2:
        nameWidgets="Infor";
        break;
      case 3:
        {
          return const Detail();
        }
      default:
        nameWidgets="None";
        break;
    }
    return DefaultWidget(title:nameWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HL mobile"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 243, 152, 33),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  user.imageURL!.length < 5
                      ? const SizedBox()
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            user.imageURL!,
                          )),
                  const SizedBox(height: 8,),
                  Text(user.fullName!),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap:(){
                Navigator.pop(context);
                _selectedIndex=0;
                setState(() {});
              }
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text("History"),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex=1;
                setState(() {
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text("Cart"),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex=2;
                setState(() {
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text("Page 1"),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex=0;
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=> const Page1()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text("Page 2"),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex=0;
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>const Page2()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text("Page 3"),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex=0;
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>const Page3()));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            user.accountId==''
              ?const SizedBox()
              :ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Logout"),
                onTap: () {
                  logOut(context);
                },
              )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label:'User'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _loadWidget(_selectedIndex),
    );
  }
}
