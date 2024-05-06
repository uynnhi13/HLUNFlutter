import 'package:flutter/material.dart';
import 'package:hlmobile/config/const.dart';
import 'package:hlmobile/model/bill.dart';
import 'package:intl/intl.dart';

class HistoryDetail extends StatelessWidget {
  final List<BillDetailModel> bill;
  const HistoryDetail({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    int tongSanPham = 0;
    int tongThanhToan = 0;

    //TÍnh tổng sản phẩm và tổng tiền
    for (var data in bill) {
      tongSanPham += data.count;
      tongThanhToan += data.price * data.count;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Chi tiết đơn hàng",
            style: textTitle(24),
          ),
          iconTheme: IconThemeData(color: colorTitle),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, bottom: 25, top: 25, right: 25),
              child: Column(
                children: [
                  Text(
                    "Cảm ơn vì đã đặt hàng tại HLMobile!",
                    style: textTitle(20),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hóa Đơn Đặt Hàng",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: bill.length,
                          itemBuilder: (context, index) {
                            var data = bill[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image(
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(data.imageUrl)),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.productName,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            NumberFormat('#,##0')
                                                .format(data.price),
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.red,
                                            ),
                                          ),
                                          // const SizedBox(height: 4.0),
                                          // Text('Category: ${pro.catId}'),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            'Số lượng: ' +
                                                data.count.toString(),
                                            style: TextStyle(fontSize: 17),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Tổng số sản phẩm: $tongSanPham',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Tổng thanh toán: ${NumberFormat('#,##0').format(tongThanhToan)} VNĐ',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
