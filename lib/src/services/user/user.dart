import 'dart:convert';

import 'package:sales_app/src/services/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  UserService._internal();
  static UserService instance = UserService._internal();
  factory UserService() {
    return instance;
  }

  Future<List<UserModel>> getUserDetails() async {
    List<UserModel> categoryList = [];

    var resp = await http.get(Uri.parse(
      'https://api.storerestapi.com/products',
    ));

    if (resp.statusCode == 200) {
      var jsonResponse = json.decode(resp.body);
      List responseList = jsonResponse['data'];

      for (var response in responseList) {
        if (response['status'] == '0') {
          response['status'] = false;
        } else {
          response['status'] = true;
        }
        categoryList.add(UserModel.fromJson(response));
      }

      for (UserModel user in categoryList) {
        print(user.categoryName);
        print(user.createdBy);
        print(user.createdAt);
        print(user.description);
        print(user.price);
        print(user.role);
        print(user.slug);
        print(user.title);
        print('--------------------');
      }
    } else {
      Exception('No document found');
    }
    return categoryList;
  }
}
