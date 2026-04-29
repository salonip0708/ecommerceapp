import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List mydata = [];

  @override
  void initState() {
    super.initState();
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 21, 171, 13),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mydata.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        mydata[index]['image'].toString(),
                      ),
                    ),

                    title: Text(
                      mydata[index]['title'].toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    subtitle: Text(
                      "₹ ${mydata[index]['price'].toString()}",
                    ),

                    trailing: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 10),
          Text(""),
          Text(""),
          Text(""),

          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Created by Saloni",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void apicall() async {
    var url = Uri.https('fakestoreapi.com', 'products');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);

      setState(() {
        mydata = jsondata;
      });
    }
  }
}