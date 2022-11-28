import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sales_app/src/screens/home_screen.dart';
import 'package:sales_app/src/services/model/user_model.dart';

import '../utils/progress_view.dart';

class ProductsScreen extends StatefulWidget {
  List<UserModel> list;
  ProductsScreen({super.key, required this.list});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<UserModel> userModelList = [];
  late ThemeData themeData;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    userModelList = widget.list;

    print(userModelList.length);

    for (UserModel i in userModelList) {
      print(i.categoryName);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        return await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Products'),
          ),
          body: SafeArea(
            child: KeyboardDismissOnTap(
              child: ProgressWidget(
                  isShow: isLoading,
                  color: Colors.black,
                  opacity: 1,
                  child: productScreenUIBody()),
            ),
          )),
    );
  }

  Widget productScreenUIBody() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          runSpacing: 5,
          spacing: 5,
          children: [for (UserModel model in userModelList) cardUI(model)],
        ),
      ),
    );
  }

  Widget cardUI(UserModel choice) {
    return Container(
      color: Colors.black,
      height: 230,
      width: MediaQuery.of(context).size.width / 3.5,
      child: Column(children: <Widget>[
        choice.categoryName == "women's fashion"
            ? SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/imgs/womes.jpg',
                ),
              )
            : choice.categoryName == "men's fashion"
                ? SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/imgs/mens.png'))
                : SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/imgs/mens.png',
                    ),
                  ),
        SizedBox(
          height: 3,
        ),
        Flexible(
          child: SizedBox(
            height: 50,
            child: Text(
              choice.title,
              style:
                  themeData.textTheme.subtitle2!.copyWith(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Price (Rs) : ${choice.price.toString()}',
          style: themeData.textTheme.subtitle1!.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
