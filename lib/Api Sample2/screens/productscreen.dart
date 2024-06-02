import 'package:apiintegration/Api%20Sample2/service/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
  runApp(GetMaterialApp(initialRoute: '/',
  getPages: [
    GetPage(name: '/', page: () => CategoryScreen(),),
    GetPage(name: '/categoryDetails', page: () => CategoryDetailsScreen(),)
  ],));
}

class CategoryScreen extends StatelessWidget {
  final FakeStoreService fakestoreservice = FakeStoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Categories"),
      ),
      body: FutureBuilder<List<String>>(
        future: fakestoreservice.getMainCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          } else {
            List<String> mainCategories = snapshot.data!;
            return ListView.builder(
              itemCount: mainCategories.length,
              itemBuilder: (context, index) {
                String category = mainCategories[index];
                return ListTile(
                  title: Text(category),
                  onTap: () {
                    Get.toNamed('/categoryDetails', arguments: category);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CategoryDetailsScreen extends StatelessWidget {
  final FakeStoreService fakestoreService = FakeStoreService();
  final String selectedCategory = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$selectedCategory Details"),
      ),
      body: FutureBuilder<List<Map<String,dynamic>>>(
        future: fakestoreService.getProductsByCategory(selectedCategory),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          } else {
            List<Map<String, dynamic>> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Map<String,dynamic>product=products[index];
                return ListTile(
                  title: Text(product['title']),
                  subtitle: Text(product['description']),
                //   trailing: CachedNetworkImage(
                // imageUrl: product['image'],
                // fit: BoxFit.contain,)
                );
              },
            );
          }
        },
      ),
    );
  }
}
