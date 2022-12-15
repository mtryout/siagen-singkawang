// ignore_for_file: library_private_types_in_public_api, unused_field, unused_import, avoid_print, file_names, depend_on_referenced_packages
import 'dart:convert';

import 'package:bananalive/common/my_const.dart';
import 'package:bananalive/common/my_helper.dart';
import 'package:bananalive/models/news_list_model.dart';
import 'package:bananalive/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../services/api.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen>
    with TickerProviderStateMixin {
  final int _currentIndex = 0;

  late ScrollController scrollController;
  late AnimationController controller;
  late AnimationController opacityController;
  late Animation<double> opacity;

  @override
  void initState() {
    scrollController = ScrollController();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    opacityController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 1));
    opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: opacityController,
    ));
    scrollController.addListener(() {
      opacityController.value = offsetToOpacity(
          currentOffset: scrollController.offset,
          maxOffset: scrollController.position.maxScrollExtent / 2);
    });

    _showData(true);

    super.initState();
  }

  double offsetToOpacity({
    required double currentOffset,
    required double maxOffset,
    double returnMax = 1,
  }) {
    return (currentOffset * returnMax) / maxOffset;
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.only(top: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 5.0),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 13.0),
                      ListView.builder(
                        padding: const EdgeInsets.only(top: 10.0),
                        itemCount: newsProvider.listData.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          var animation =
                              Tween<double>(begin: 800.0, end: 0.0).animate(
                            CurvedAnimation(
                              parent: controller,
                              curve: Interval(
                                  (1 / newsProvider.listData.length) * index,
                                  1.0,
                                  curve: Curves.decelerate),
                            ),
                          );
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) => Transform.translate(
                              offset: Offset(animation.value, 0.0),
                              child: NewsScreenDetail(
                                datum: newsProvider.listData[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showData(bool clearListParent) async {
    await Provider.of<NewsProvider>(context, listen: false)
        .showListData(clearListParent);
  }

  // Future<List<NewsModel>> getData(var params) async {
  //   final response = await http
  //       .get(Uri.parse("http://agen-126.singkawangkota.go.id/api/posts"));

  //   var data = await API.post('${API.apiUrl}login', params);

  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     final js = json.decode(response.body);
  //     List jsonResponse = js['data'];
  //     return jsonResponse.map((data) => NewsModel.fromJson(data)).toList();
  //   } else {
  //     throw Exception('Terjadi kesalahan tak terduga!');
  //   }
  // }

  // void viewEventDetail(BuildContext context, NewsModel news) {
  //   Navigator.of(context).push(
  //     PageRouteBuilder(
  //       opaque: false,
  //       barrierDismissible: true,
  //       transitionDuration: const Duration(milliseconds: 300),
  //       pageBuilder: (BuildContext context, animation, __) {
  //         return FadeTransition(
  //           opacity: animation,
  //           child: NewsDetailScreen(news),
  //         );
  //       },
  //     ),
  //   );
  // }
}

class NewsScreenDetail extends StatelessWidget {
  final Datum? datum;
  const NewsScreenDetail({Key? key, this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.white,
                width: 125.0,
                height: 100.0,
                child: Hero(
                  tag: 'dash',
                  child: Image.network(
                    '${API.imgUrl}${datum?.gambar}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(datum?.title ?? '-',
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 20.0))),
                    const SizedBox(height: 12.0),
                    SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.date_range,
                              size: 20.0, color: Theme.of(context).primaryColor),
                          const SizedBox(width: 12.0),
                          Text(
                            MyHelper.formatIndoDateTime(datum?.createdAt.toString()),
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 15.0)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
