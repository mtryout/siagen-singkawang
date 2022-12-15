// ignore_for_file: library_private_types_in_public_api, unused_field, unused_import, avoid_print, file_names, depend_on_referenced_packages
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:singkawang/common/my_const.dart';
import 'package:singkawang/common/my_helper.dart';
import 'package:singkawang/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:singkawang/screens/news/news_detail.dart';

import '../../models/news/news_list_model.dart';
import '../../services/api.dart';

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
      body: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
            alignment: Alignment.topCenter,
            color: const Color(0xFFF0F0F0),
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.newspaper, color: Colors.grey),
                    const SizedBox(
                      width: 15,
                    ),
                    RichText(
                      text: const TextSpan(
                          text: "Daftar Berita",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF263064),
                            fontSize: 22,
                          ),
                          children: [
                            TextSpan(
                              text: " ",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
                const Text(
                  "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF3E3993),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15.0),
              child: SmartRefresher(
                controller: newsProvider.refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () => _showData(true),
                onLoading: () => _loading(),
                child: ListView.builder(
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
                            (1 / newsProvider.listData.length) * index, 1.0,
                            curve: Curves.decelerate),
                      ),
                    );
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) => Transform.translate(
                        offset: Offset(animation.value, 0.0),
                        child: ItemNews(
                          datum: newsProvider.listData[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double offsetToOpacity({
    required double currentOffset,
    required double maxOffset,
    double returnMax = 1,
  }) {
    return (currentOffset * returnMax) / maxOffset;
  }

  void _loading() {
    _showData(false);
  }

  Future<void> _showData(bool clearListParent) async {
    await Provider.of<NewsProvider>(context, listen: false)
        .showListData(clearListParent);
  }
}

class ItemNews extends StatelessWidget {
  final Datum? datum;
  const ItemNews({Key? key, this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              barrierDismissible: true,
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (BuildContext context, animation, __) {
                return FadeTransition(
                  opacity: animation,
                  child: NewsDetailScreen(datum!),
                );
              },
            ),
          );

          // MyHelper.navPush(NewsDetailScreen(datum!));
        },
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.white,
                width: 150.0,
                height: 120.0,
                child: Hero(
                  tag: 'dash${datum?.id}',
                  child: Image.network(
                    datum?.gambar ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 12.0, bottom: 12.0, top: 12.0, right: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(datum?.title ?? '-',
                        maxLines: 3,
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
                          const Icon(Icons.date_range,
                              size: 20.0, color: Colors.blueGrey),
                          const SizedBox(width: 8.0),
                          Text(
                            MyHelper.formatIndoDate(
                                datum?.createdAt.toString()),
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
