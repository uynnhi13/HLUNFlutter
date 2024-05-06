import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hlmobile/config/const.dart';
import 'package:hlmobile/data/api.dart';
import 'package:hlmobile/data/sqlite.dart';
import 'package:hlmobile/model/cart.dart';
import 'package:hlmobile/page/cart/payment_success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Cart>> _getProducts() async {
    return await _databaseHelper.products();
  }

  double _calculateTotal(List<Cart> products) {
    double total = 0;
    for (var product in products) {
      total += product.price * product.count;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Cart>>(
            future: _getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Your cart is empty.'),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final itemProduct = snapshot.data![index];
                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                DatabaseHelper()
                                    .deleteProduct(itemProduct.productID);
                              });
                            },
                            background: Container(
                              color: Colors.red[400],
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerRight,
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: _buildProduct(itemProduct, context),
                          );
                        },
                      ),
                    ),
                  ),
                  // Tổng thanh toán
                  Padding(
                    padding: const EdgeInsets.all(36),
                    child: Container(
                      decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                            'Tổng thanh toán:',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            NumberFormat('#,##0')
                                .format(_calculateTotal(snapshot.data!)),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              List<Cart> temp =
                                  await _databaseHelper.products();
                              await APIRepository().addBill(
                                  temp, pref.getString('token').toString());
                              _databaseHelper.clear();
                              setState(() {
                                
                              });
                              Navigator.push(context, MaterialPageRoute(builder:(context) => const PaymentSuccess(subTitle: "Vui lòng kiểm tra ở phần lịch sử đơn hàng", title: "Thanh Toán Thành Công"),));
                            },
                            child: const Text("Payment",style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorPrimary, // Đặt màu nền là màu xanh
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Đặt bán kính bo tròn
                                side: BorderSide(
                                    color: Colors
                                        .white), // Đặt đường viền màu trắng
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProduct(Cart pro, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
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
                    NumberFormat('#,##0').format(pro.price * pro.count),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Description: ' + pro.des,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                //minus button
                Container(
                  padding: EdgeInsets.only(bottom: 6),
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          DatabaseHelper().minus(pro);
                        });
                      },
                      icon: Icon(
                        Icons.minimize,
                        color: colorPrimary,
                        size: 18,
                      )),
                ),
                //quantity count
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      pro.count.toString(),
                      style: const TextStyle(
                        color: colorPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //plus button
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          DatabaseHelper().add(pro);
                        });
                      },
                      icon: Icon(Icons.add, color: colorPrimary, size: 18)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
