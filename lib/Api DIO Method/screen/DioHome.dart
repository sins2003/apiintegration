
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../controller/DioController.dart';
import '../utils/DioColors.dart';
import '../utils/DioSnackBar.dart';
import 'DioDetails.dart';

void main() {
  runApp(GetMaterialApp(
    home: HomePost(),
  ));
}

class HomePost extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bgcolor,
      appBar: buildAppBar(),
      floatingActionButton: Obx(() =>
      controller.isInternetConnected.value ? buildFAB() : Container()),
      body: Obx(
            () => SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: controller.isInternetConnected.value
                ? controller.isLoading.value
                ? buildLoading()
                : buildMainBody()
                : buildNoInternetConnection(context)),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: MyColor.prcolor,
      centerTitle: true,
      title: const Text("Get Api from Dio"),
    );
  }

  FloatingActionButton buildFAB() {
    return FloatingActionButton(
        backgroundColor: MyColor.prcolor,
        onPressed: () {
          controller.isListScrollDown.value
              ? controller.scrolllistUpWard()
              : controller.scrollListDownWard();
        },
        child: FaIcon(controller.isListScrollDown.value
            ? FontAwesomeIcons.arrowUp
            : FontAwesomeIcons.arrowDown));
  }

  Center buildLoading() {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: Lottie.network(
            "https://assets6.lottiefiles.com/packages/lf20_mzrkxt2h.json"),
      ),
    );
  }

  Center buildNoInternetConnection(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child: Lottie.asset(
                "assets/animation/45721-no-internet.json"),
          ),
          MaterialButton(
            onPressed: () => onTapButton(context),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: MyColor.prcolor,
            child: const Text(
              "Try Again",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  void onTapButton(BuildContext context) async {
    if (await InternetConnectionChecker().hasConnection == true) {
      controller.getPosts();
    } else {
      showCustomSnackBar(context);
    }
  }

  RefreshIndicator buildMainBody() {
    return RefreshIndicator(
        onRefresh: (){
          return controller.getPosts();
        },
        child: ScrollablePositionedList.builder(
            itemScrollController: controller.itemController,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(DetailsPage(index: index),
                      transition: Transition.leftToRightWithFade);
                },
                child: Card(
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Text(controller.posts[index].id.toString())),
                    ),
                    title: Text(
                      controller.posts[index].title,
                      style: const TextStyle(color: Colors.lightGreenAccent),
                    ),
                    subtitle: Text(
                      controller.posts[index].body,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
            }));
  }
}