import 'package:flutter/material.dart';
import 'package:hlmobile/config/const.dart';
import 'package:hlmobile/data/api.dart';
import 'package:hlmobile/mainpage.dart';
import 'package:hlmobile/page/product/product_data_sell.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess(
      {super.key,
      required this.subTitle,
      required this.title});
  final String title, subTitle ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 140, 30, 40),
        child: Column(
          children: [
            Lottie.asset(
                'assets/images/Animation-1714714604754.json'),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: colorTitle,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              subTitle,
              style: const TextStyle(
                  color: colorTitle,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            
             
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                ElevatedButton.icon(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context) => const Mainpage(),));
                      },
                      label: Text('Về trang chủ '),
                      icon: Icon(Icons.home),
                      style: ButtonStyle(
                        maximumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            colorTitle), // Background color
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white), // Text color
                        elevation:
                            MaterialStateProperty.all<double>(5), // Elevation
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                          ),
                        ),
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.yellow; // Màu khi di chuột qua
                            }
                            return colorPrimary; // Sử dụng màu mặc định
                          },
                        ),
                        animationDuration: const Duration(milliseconds: 5000),
                      )),
                     
                    ],
            ),
            
          ],
        ),
      ),
    ));
  }
}