// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:singkawang/models/news_model.dart' as news_model;
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:singkawang/services/api.dart';

import '../common/my_helper.dart';

class NewsProvider with ChangeNotifier {
  Data? profile;

  RefreshController refreshController = RefreshController(initialRefresh: true);
  String filterMelebihiDeadline = '0';
  List<news_model.Datum> listData = [];
  int page = 1;
  bool loading = false;

  news_model.NewsModel? detailData;
  bool loadingDetail = false;

  Future<void> showListData(bool clearListParent, String cari) async {
    page++;

    if (clearListParent) {
      page = 1;
      loading = true;
      notifyListeners();
    }

    var params = {
      'page': page,
      'filter_melebihi_deadline': filterMelebihiDeadline,
      'cari': cari
    };

    var data = await API.get('${API.apiUrl}posts', params);
    var result = news_model.NewsModel.fromJson(data);

    List<news_model.Datum> tempListData = [];

    if (result.status!) {
      for (var element in result.data!.data!) {
        tempListData.add(element);
      }

      if (clearListParent) listData.clear();

      if (tempListData.isEmpty) {
        page--;
        refreshController.loadNoData();
      } else {
        listData.addAll(tempListData);
        refreshController.loadComplete();
      }
    } else {
      refreshController.refreshCompleted();
      await MyHelper.dialogOk(DialogType.ERROR, result.message ?? '-', () {});
    }

    loading = false;
    refreshController.refreshCompleted();
    notifyListeners();
  }

  Future<void> showDetailData(int id) async {
    loadingDetail = true;

    var data = await API.get('${API.apiUrl}posts/$id', null);
    var result = news_model.NewsModel.fromJson(data);

    if (result.status!) {
      detailData = result;
    } else {
      await MyHelper.dialogOk(DialogType.ERROR, result.message ?? '-', () {});
    }

    loadingDetail = false;
    notifyListeners();
  }
}
