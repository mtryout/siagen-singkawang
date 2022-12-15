// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:singkawang/common/my_helper.dart';

import '../../models/news/news_list_model.dart';

class NewsDetailScreen extends StatefulWidget {
  final Datum news;
  NewsDetailScreen(this.news, {Key? key}) : super(key: key);
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController bodyScrollAnimationController;
  late Animation<double> scale;
  late Animation<double> appBarSlide;
  double headerImageSize = 0;
  bool isFavorite = false;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    bodyScrollAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    appBarSlide = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: bodyScrollAnimationController,
    ));

    scale = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: controller,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    bodyScrollAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    headerImageSize = MediaQuery.of(context).size.height / 2.3;
    return 
    ScaleTransition(
      scale: scale,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildHeaderImage(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildTitle(),
                          const SizedBox(height: 16.0),
                          buildDate(),
                          const SizedBox(height: 24.0),
                          buildEvent(),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: appBarSlide,
                builder: (context, snapshot) {
                  return Transform.translate(
                    offset: Offset(0.0, -1000 * (1 - appBarSlide.value)),
                    child: Material(
                      elevation: 2,
                      color: Colors.indigo,
                      child: buildHeaderButton(hasTitle: true),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderImage() {
    double maxHeight = MediaQuery.of(context).size.height;
    double minimumScale = 0.8;
    return GestureDetector(
      onVerticalDragUpdate: (detail) {
        controller.value += detail.primaryDelta! / maxHeight * 2;
      },
      onVerticalDragEnd: (detail) {
        if (scale.value > minimumScale) {
          controller.reverse();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: headerImageSize,
            child: Hero(
              tag: 'dash',
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(28.0)),
                child: Image.network(
                  widget.news.gambar ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          buildHeaderButton(),
        ],
      ),
    );
  }

  Widget buildHeaderButton({bool hasTitle = false}) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                if (bodyScrollAnimationController.isCompleted) {
                  bodyScrollAnimationController.reverse();
                }
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 28.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Text(
      widget.news.title ?? '-',
      textAlign: TextAlign.center,
      style: GoogleFonts.roboto(
          textStyle:
              const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500)),
    );
  }

  Widget buildDate() {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.date_range,
                  size: 28.0, color: Theme.of(context).primaryColor),
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Tanggal',
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))),
            const SizedBox(width: 4.0),
            Text(MyHelper.formatIndoDate(widget.news.createdAt.toString()),
                style: GoogleFonts.roboto(
                    textStyle:
                        const TextStyle(fontSize: 15.0, color: Colors.grey))),
          ],
        ),
      ],
    );
  }

  Widget buildEvent() {
    String html = widget.news.content ?? '-';
    final markdown = html2md.convert(html);

    return ReadMoreText(
      markdown,
      style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 16.0)),
      trimLines: 10,
      trimMode: TrimMode.Line,
      trimCollapsedText: ' Baca Selengkapnya',
      trimExpandedText: ' Lebih Sedikit',
      textAlign: TextAlign.justify,
      lessStyle: GoogleFonts.roboto(
          textStyle:
              const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
      moreStyle: GoogleFonts.roboto(
          textStyle:
              const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
    );
  }
}
