import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suitmedia_test/View-Model/third_screen.dart';
import 'package:http/http.dart' as http;

import '../Model/data_model.dart';

class ThirdScreenv2 extends StatefulWidget {
  const ThirdScreenv2({super.key});

  @override
  State<ThirdScreenv2> createState() => _ThirdScreenv2State();
}

class _ThirdScreenv2State extends State<ThirdScreenv2> {
  int page = 1;

  List<UsersModel> datauser = [];
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getusers({bool isRefresh = false}) async {
    if (isRefresh) {
      page = 1;
    }

    final dio = Dio();
    String url = "https://reqres.in/api/users?page=$page";
    final res = await dio.get(url);
    if (res.statusCode == 200) {
      final List data = res.data["data"];
      page++;
      datauser = data.map((e) => UsersModel.fromJson(e)).toList();
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: const Color.fromRGBO(85, 74, 240, 1),
        ),
        title: const Text("Third Screen"),
        centerTitle: true,
      ),
      body: SmartRefresher(
        enablePullUp: true,
        onLoading: () async {
          final result = await getusers();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        controller: refreshController,
        onRefresh: () async {
          final result = await getusers(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        child: datauser.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  final user = datauser[index];
                  return ListTile(
                    onLongPress: () {
                      final selectuser = datauser.elementAt(index);
                      context
                          .read<ThirdScreenProvider>()
                          .selectedUser(selectuser);
                      Navigator.pop(context);
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${user.avatar}"),
                    ),
                    title: Text(
                      "${user.firstName} ${user.lastName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    subtitle: Text(
                      "${user.email}".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(104, 103, 119, 1)),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: datauser.length)
            : Center(
                child: Text("No Data"),
              ),
      ),
    );
  }
}
