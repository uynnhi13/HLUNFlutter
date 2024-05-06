import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hlmobile/config/const.dart';
import 'package:hlmobile/data/api.dart';
import 'package:hlmobile/data/sqlite.dart';
import 'package:hlmobile/model/cart.dart';
import 'package:hlmobile/model/product.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductBuilderSell extends StatefulWidget {
  const ProductBuilderSell({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductBuilderSell> createState() => _ProductBuilderSellState();
}

class _ProductBuilderSellState extends State<ProductBuilderSell> {
  Future<List<ProductModel>> _getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await APIRepository().getProduct(
        prefs.getString('accountID').toString(),
        prefs.getString('token').toString());
  }

  _addToCart(ProductModel product) async {
    Cart productAdd = Cart(
        name: product.name,
        price: product.price,
        img: product.imgURL,
        des: product.desc,
        count: 1,
        productID: product.id!);
    await DatabaseHelper().insertProduct(productAdd);
    // Hiển thị SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã thêm ${product.name} vào giỏ hàng', style: TextStyle(fontSize: 18),),
        duration:
            Duration(seconds: 2), 
            backgroundColor: colorPrimary,// Đặt thời gian hiển thị SnackBar là 2 giây
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final itemProduct = snapshot.data![index];
              return _buildProduct(itemProduct, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildProduct(ProductModel pro, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              alignment: Alignment.center,
              child: Image(
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  image: NetworkImage(pro.imgURL)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pro.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    NumberFormat('#,##0').format(pro.price),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.red,
                    ),
                  ),
                  // const SizedBox(height: 4.0),
                  // Text('Category: ${pro.catId}'),
                  const SizedBox(height: 4.0),
                  Text(
                    'Description: ' + pro.desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () async {
                  _addToCart(pro);
                  setState(() {});
                },
                icon: const Icon(
                  CupertinoIcons.cart,
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}
