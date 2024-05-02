import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hlmobile/data/api.dart';
import 'package:hlmobile/model/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<CategoryModel> cateList = [];
  getListCate() async {
    try {
      List<CategoryModel> listCate = await APIRepository().getCateList();
      if (listCate.isNotEmpty) {
        // Xử lý dữ liệu khi danh sách không rỗng
        setState(() {
          cateList = listCate;
        });
      } else {
        // Xử lý khi danh sách rỗng
        // Ví dụ: Hiển thị thông báo cho người dùng
        print("Danh sách rỗng");
      }
    } catch (ex) {
      // Xử lý khi có lỗi xảy ra
      // Ví dụ: Hiển thị thông báo lỗi
      print("Lỗi: $ex");
    }
  }

  @override
  void initState() {
    super.initState();
    getListCate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cateList.isEmpty
          ? Center(
              child: Text(cateList.length.toString()),
            )
          : ListView.builder(
              itemCount: cateList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cateList[index].name),
                  subtitle: Text(cateList[index].desc),
                  leading:
                      Image.network(cateList[index].imgURLCate), // Hiển thị hình ảnh
                  trailing: Text('ID: ${cateList[index].id}'), // Hiển thị ID
                );
              },
            ),
    );
  }
}
