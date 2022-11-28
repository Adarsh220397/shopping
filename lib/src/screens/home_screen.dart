import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sales_app/src/screens/products_screen.dart';
import 'package:sales_app/src/services/model/category_model.dart';
import 'package:sales_app/src/services/model/user_model.dart';
import 'package:sales_app/src/utils/progress_view.dart';

import '../services/user/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData themeData;
  bool isLoading = false;
  int _currentIndex = 0;
  List<UserModel> list = [];
  List<CategoryModel> categories = [
    CategoryModel(image: 'assets/imgs/mens.png', categoryName: 'Men'),
    CategoryModel(image: 'assets/imgs/womes.jpg', categoryName: 'Women')
  ];
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  //String categoryName = '';
  Future<void> fetchData() async {
    // suggestionList.clear();
    isLoading = true;
    list = await UserService.instance.getUserDetails();

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: SafeArea(
          child: KeyboardDismissOnTap(
            child: ProgressWidget(
                isShow: isLoading,
                color: Colors.black,
                opacity: 1,
                child: loginDetailsScreenBodyUI()),
          ),
        ));
  }

  Widget loginDetailsScreenBodyUI() {
    return Stack(
      children: <Widget>[
        Positioned(
            top: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: optionsUI()),
      ],
    );
  }

  Widget optionsUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: true,
              initialPage: 0,
              height: 270,
              reverse: false,
              scrollDirection: Axis.horizontal,
              aspectRatio: 2.0,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: const Duration(milliseconds: 400),
              autoPlayInterval: const Duration(seconds: 4),
              viewportFraction: 0.9,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
              pageViewKey: const PageStorageKey<String>('carousel_slider'),
            ),
            items: categories.map((item) => categoryUI(item)).toList()),
        dotIndication(),
      ],
    );
  }

  Widget categoryUI(CategoryModel category) {
    return InkWell(
      onTap: () async {
        if (category.categoryName == 'Men') {
          list.removeWhere(
              (element) => element.categoryName != "men's fashion");

          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductsScreen(
                        list: list,
                      )));
        } else if (category.categoryName == 'Women') {
          list.removeWhere(
              (element) => element.categoryName != "women's fashion");

          bool back = await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductsScreen(
                        list: list,
                      )));

          if (back) {
            fetchData();
          }
        }
      },
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset(category.image, height: 200, width: 200),
          ),
          Text(
            category.categoryName,
            style: themeData.textTheme.subtitle1!.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget dotIndication() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: categories.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
              width: 12.0,
              height: 12.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.blue)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4))),
        );
      }).toList(),
    );
  }
}
