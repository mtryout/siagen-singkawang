// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../common/my_helper.dart';
import '../models/news/news_list_model.dart';
import '../services/api.dart';

class NewsProvider with ChangeNotifier {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  List<Datum> listData = [];
  int page = 1;
  bool loading = false;

  Future<void> showListData(bool clearListParent) async {
    page++;

    if (clearListParent) {
      page = 1;
      loading = true;
      // notifyListeners();
    }

    var params = {
      'page': page,
    };

    var data = await API.get('${API.apiUrl}posts', params);
    var result = NewsListModel.fromJson(data);

    List<Datum> tempListData = [];

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

  // Future<void> showDetailData(int id) async {
  //   loadingDetail = true;

  //   var data = await API.get(API.apiUrl + 'peminjaman/single-data/$id', null);
  //   var result = peminjaman_detail_model.PeminjamanDetailModel.fromJson(data);

  //   if (result.status!) {
  //     detailData = result;
  //   } else {
  //     await MyHelper.dialogOk(DialogType.ERROR, result.message ?? '-', () {});
  //   }

  //   loadingDetail = false;
  //   notifyListeners();
  // }

  // Future<void> peminjamanData(var params) async {
  //   loadingPeminjaman = true;
  //   notifyListeners();

  //   var data = await API.postMiltipart(
  //       API.apiUrl + 'peminjaman/update-or-create-data', params, () {});
  //   var result = CommonModel.fromJson(data);

  //   if (result.status!) {
  //     filterMelebihiDeadline = '0';
  //     showListData(true, '');
  //     MyHelper.navPop(null);
  //     await MyHelper.dialogOk(DialogType.SUCCES, result.message ?? '-', () {});
  //   } else {
  //     await MyHelper.dialogOk(DialogType.ERROR, result.message ?? '-', () {});
  //   }

  //   loadingPeminjaman = false;
  //   notifyListeners();
  // }

  // Future<void> kembalikanData(var params) async {
  //   loadingPengembalian = true;
  //   notifyListeners();

  //   var data = await API.postMiltipart(
  //       API.apiUrl + 'pengembalian/update-or-create-data', params, () {});
  //   var result = CommonModel.fromJson(data);

  //   if (result.status!) {
  //     filterMelebihiDeadline = '0';
  //     showListData(true, '');
  //     MyHelper.navPop(null);
  //     MyHelper.navPop(null);
  //     await MyHelper.dialogOk(DialogType.SUCCES, result.message ?? '-', () {});
  //   } else {
  //     await MyHelper.dialogOk(DialogType.ERROR, result.message ?? '-', () {});
  //   }

  //   loadingPengembalian = false;
  //   notifyListeners();
  // }

  // Future<void> setPenomoranJudul(String penomoranJudul) async {
  //   await MyHelper.setPref(MyConst.penomoranJudul, penomoranJudul);
  // }

  // Future<String?> getPenomoranJudul() {
  //   return MyHelper.getPref(MyConst.penomoranJudul);
  // }
}
