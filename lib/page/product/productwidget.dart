import 'package:flutter/material.dart';
import 'package:hlmobile/data/api.dart';
import 'package:hlmobile/model/product.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<ProductModel> proList = [];
  getListProduct() async {
    try {
      List<ProductModel> listPro = await APIRepository().getProductList();
      setState(() {
        proList = listPro;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: proList.length,
        itemBuilder: (context, index) {
          final product = proList[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0), // Bo tròn viền
            ),
            child: ListTile(
              title: Text(
                proList[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                proList[index].desc, maxLines: 2, // Số dòng tối đa
                overflow: TextOverflow.ellipsis,
              ),
              leading: FadeInImage.assetNetwork(
                placeholder:
                    proList[index].imgURL, // Hình ảnh placeholder
                image: proList[index].imgURL,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image, 
                    weight: 50,
                  );
                },
              ),
              onTap: () {
                // Thêm logic điều hướng ở đây nếu cần
              },
            ),
          );
        },
      ),
    );
  }
}
