import 'package:flutter/material.dart';
import 'package:hlmobile/config/const.dart';
import 'package:hlmobile/data/api.dart';
import 'package:hlmobile/model/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryAdd extends StatefulWidget {
  final bool isUpdate;
  final CategoryModel? categoryModel;
  const CategoryAdd({super.key, this.isUpdate = false, this.categoryModel});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String titleText = "";
  Future<void> _onSave() async {
    final name = _nameController.text;
    final description = _descController.text;
    final image = _imageController.text;
    var pref = await SharedPreferences.getInstance();
    await APIRepository().addCategory(
        CategoryModel(id: 0, name: name, imgURLCate: image, desc: description),
        pref.getString('accountID').toString(),
        pref.getString('token').toString());
    // await _databaseService
    //     .insertCategory(CategoryModel(name: name, desc: description));
    setState(() {});
    Navigator.pop(context);
  }

  Future<void> _onUpdate(int id) async {
    final name = _nameController.text;
    final description = _descController.text;
    final image = _imageController.text;
    var pref = await SharedPreferences.getInstance();

    //update
    await APIRepository().updateCategory(
        id,
        CategoryModel(
            id: widget.categoryModel!.id,
            name: name,
            imgURLCate: image,
            desc: description),
        pref.getString('accountID').toString(),
        pref.getString('token').toString());
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.categoryModel != null && widget.isUpdate) {
      _nameController.text = widget.categoryModel!.name;
      _descController.text = widget.categoryModel!.desc;
    }
    if (widget.isUpdate) {
      titleText = "Update Category";
    } else
      titleText = "Add New Category";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textInput("Hãng điện thoại", _nameController),
            const SizedBox(
              height: 10,
            ),
            textInput("Đường dẫn IMG", _imageController),
            const SizedBox(
              height: 10,
            ),
            textInput("Mô tả", _descController),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: () {
                  widget.isUpdate
                      ? _onUpdate(widget.categoryModel!.id!)
                      : _onSave();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimary, // Màu nền của nút
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Độ cong của góc
                  ),
                ),
                child: const Text(
                  'Lưu',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
