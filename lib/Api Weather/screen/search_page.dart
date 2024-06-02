import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
  runApp(GetMaterialApp(
    home: search_page(),
  ));
}

class search_page extends StatefulWidget{
  @override
  State<search_page> createState() => _search_pageState();
}

class _search_pageState extends State<search_page> {
  var search_cntr=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WEATHER APP'),),
      body: Container(child: Column(
        children: [
          SizedBox(height: 20,),
          TextField(
            controller: search_cntr,
            decoration: InputDecoration(
              suffixIcon: Icon(CupertinoIcons.search),
              hintText: "Search Here",
              labelText: "Location",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
            ),
          ),
          ElevatedButton(onPressed: () {

          }, child: Text("Search"))
        ],
      ),),
    );
  }
}