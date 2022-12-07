// ignore_for_file: prefer_const_constructors

import 'package:warkahpintar/common/my_color.dart';
import 'package:warkahpintar/common/my_helper.dart';
import 'package:warkahpintar/models/key_model.dart';
import 'package:warkahpintar/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/my_style.dart';

class CustomSearchScreen extends StatefulWidget {
  final List<KeyModel>? dataList;
  const CustomSearchScreen({Key? key, this.dataList}) : super(key: key);

  @override
  State<CustomSearchScreen> createState() => _CustomSearchScreenState();
}

class _CustomSearchScreenState extends State<CustomSearchScreen> {
  final refreshController = RefreshController(initialRefresh: false);
  var search = TextEditingController();

  List<KeyModel>? searchList = [];

  @override
  void initState() {
    _showData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget item(int index) {
      return InkWell(
        onTap: () {
          MyHelper.navPop(searchList?[index]);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  searchList?[index].value ?? '-',
                  style: MyStyle.textParagraph
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.arrow_right)
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      width: MediaQuery.of(context).size.width - 40,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  MyHelper.navPop('');
                },
                icon: Icon(Icons.close)),
          ),
          CustomCard(
            padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            height: 55,
            borderRadius: BorderRadius.circular(10),
            bgColor: MyColor.softGrey,
            child: Center(
              child: TextFormField(
                onChanged: (val) {
                  _showData();
                },
                controller: search,
                decoration: InputDecoration(
                    hintText: 'Cari',
                    border: InputBorder.none,
                    icon: Icon(Icons.search)),
              ),
            ),
          ),
          Expanded(
            child: SmartRefresher(
                controller: refreshController,
                enablePullDown: true,
                enablePullUp: false,
                onRefresh: _showData,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  children: [
                    ...List.generate(
                        searchList!.length, (index) => item(index)),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void _showData() {
    if (search.text == '') {
      searchList = widget.dataList;
    } else {
      MyHelper.debounceSearch(() {
        setState(() {
          searchList = widget.dataList!
              .where((element) => element.value!
                  .toLowerCase()
                  .contains(search.text.toLowerCase()))
              .toList();
        });
      });
    }
  }
}
