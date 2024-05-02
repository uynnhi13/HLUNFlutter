import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hlmobile/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  //Khi dùng tham số truyền vào phải khai báo biến trùng tên require
  User user=User.userEmpty();
  getDataUser() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    String strUser=pref.getString('user')!;

    user=User.fromJson(jsonDecode(strUser));
    setState(() {
    });
  }

  @override
  void initState(){
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    //create style
    TextStyle mystyle=const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.amber,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircleAvatar(
              backgroundImage: NetworkImage(user.imageURL!),radius: 80,),
            const SizedBox(height: 15,),  
            Text("NumberID: ${user.idNumber}", style: mystyle),
            Text("Fullname: ${user.fullName}", style: mystyle),
            Text("Phone Number: ${user.phoneNumber}", style: mystyle),
            Text("Gender: ${user.gender}", style: mystyle),
            Text("birthDay: ${user.birthDay}", style: mystyle),
            Text("schoolYear: ${user.schoolYear}", style: mystyle),
            Text("schoolKey: ${user.schoolKey}", style: mystyle),
            Text("dateCreated: ${user.dateCreated}", style: mystyle),
            ],
          ),
        ),
      )
    );
  }
}