import 'package:apiintegration/Api%20DIO%20Method/services/DioServices.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../model/DioModel.dart';

class HomeController extends GetxController {
  RxList<PostModel> posts = RxList();
  RxBool isLoading = true.obs;
  RxBool isInternetConnected = true.obs;
  RxBool isListScrollDown = false.obs;

  var url = "https://jsonplaceholder.typicode.com/posts";
  var itemController = ItemScrollController();

  isInternetConnect() async {
    isInternetConnected.value = await InternetConnectionChecker().hasConnection;
  }

  getPosts() async {
    isInternetConnect();
    isLoading.value = true;
    var response = await DioService().getData(url);
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        posts.add(PostModel.fromJson(element));
      });
      isLoading(false);
    }
  }

  scrollListDownWard() {
    itemController.scrollTo(
        index: posts.length - 5,
        duration: Duration(seconds: 2),
        curve: Curves.bounceOut);
    isListScrollDown.value = true;
  }

  scrolllistUpWard() {
    itemController.scrollTo(
        index: 0, duration: Duration(seconds: 2), curve: Curves.easeInCirc);
    isListScrollDown.value=false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getPosts();
    isInternetConnect();
    super.onInit();
  }
}
