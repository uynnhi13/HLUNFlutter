import 'package:dio/dio.dart';
import 'package:hlmobile/model/category.dart';
import 'package:hlmobile/model/product.dart';
import 'package:hlmobile/model/register.dart';
import 'package:hlmobile/model/user.dart';

class API {
  final Dio _dio = Dio();
  String baseUrl = "https://huflit.id.vn:4321";
  String stheader = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiMDk4NDAxMDMwMiIsIklEIjoiMjBESDExMjEyMyIsImp0aSI6ImI3ODgzOTU0LTBkZmItNDQ0MC1hNDJiLWI2MjE2MTM1NzhiZiIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlN0dWRlbnQiLCJleHAiOjE3MjE5MjI1MjZ9.VDQR7-UsUqiJtIGdoVc4Z8u72USYlg-PXyKPsyXIY2M";

  API() {
    _dio.options.baseUrl = "$baseUrl/api";
  }

  Dio get sendRequest => _dio;
}

class APIRepository {
  API api = API();
  

  Map<String, dynamic> header(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
  }

  Future<String> register(Signup user) async {
    try {
      final body = FormData.fromMap({
        "numberID": user.numberID,
        "accountID": user.accountID,
        "fullName": user.fullName,
        "phoneNumber": user.phoneNumber,
        "imageURL": user.imageUrl,
        "birthDay": user.birthDay,
        "gender": user.gender,
        "schoolYear": user.schoolYear,
        "schoolKey": user.schoolKey,
        "password": user.password,
        "confirmPassword": user.confirmPassword
      });
      Response res = await api.sendRequest.post('/Student/signUp',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        print("ok");
        return "ok";
      } else {
        print("fail");
        return "signup fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> login(String accountID, String password) async {
    try {
      final body =
          FormData.fromMap({'AccountID': accountID, 'Password': password});
      Response res = await api.sendRequest.post('/Auth/login',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        final tokenData = res.data['data']['token'];
        print("ok login");
        return tokenData;
      } else {
        return "login fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<User> current(String token) async {
    try {
      Response res = await api.sendRequest
          .get('/Auth/current', options: Options(headers: header(token)));
      return User.fromJson(res.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCateList() async {
    try {
      print("đã vào");
      Response res = await api.sendRequest.get(
        '/Category/getList',
        options: Options(
            headers: header(
                api.stheader)),
        queryParameters: {'accountID': '20DH112123'},
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
        //Dữ liệu trả về là một danh sách các category
        print("đã vào 1");
        List<dynamic> cateData = res.data;
        print(cateData);
        List<CategoryModel> cateList =
            cateData.map((item) => CategoryModel.fromMap(item)).toList();
        print("Đây là cateList: $cateList");
        return cateList;
      } else {
        //Nếu không thành công thì in ra lỗi và trả về một danh sách rỗng
        return [];
      }
    } catch (ex) {
      print("Lỗi ở đây là: $ex");
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductList() async{
    try{
      Response res = await api.sendRequest.get(
        '/Product/getList',
        options: Options(
            headers: header(api.stheader)),
        queryParameters: {'accountID': '20DH112123'},
      );

      if(res.statusCode==200){
        List<dynamic> productData=res.data;
        List<ProductModel> productList=productData.map((e) => ProductModel.fromMap(e)).toList();
        print("Đây là ProductList: $productList");
        return productList;
      }
      else {
        return [];
      }

    }catch (e){
      print("Bị lỗi: $e");
      rethrow;
    }
  }
}
