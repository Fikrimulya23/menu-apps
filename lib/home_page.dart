import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:menu_apps/add_menu.dart';
import 'package:menu_apps/const.dart';
import 'package:menu_apps/login_page.dart';
import 'package:menu_apps/main.dart';

class HomePage extends StatefulWidget {
  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) => HomePage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getMenu() async {
    final String url = "$baseURL/api/list";

    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };

    var response = await http.get(Uri.parse(url), headers: headers);
    if (mounted) if (response.statusCode == 201) {
      print("XXXXXXXXX");
      print(response.body);
      print("XXXXXXXXX");
      return jsonDecode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Aplikasi Menu Makanan"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return AddMenu();
              },
            ));
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(7, 10, 7, 10),
          child: FutureBuilder(
              // child: StreamBuilder(
              future: getMenu(),
              // stream: getProduct2(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: (snapshot.data as dynamic)['data'].length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            /* decoration: BoxDecoration(
                              border: Border.all(),
                            ), */
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  child: Image.network(
                                    "$baseURL" +
                                        ((snapshot.data as dynamic)['data']
                                            [index]['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (snapshot.data as dynamic)['data']
                                                  [index]['name'] +
                                              "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Rp. " +
                                              (snapshot.data as dynamic)['data']
                                                  [index]['price'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.more_vert)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Container(
                  child: Center(
                    child: Text("Belum ada menu"),
                  ),
                );
              }),
        ),
        /* body: Center(
          child: Column(
            children: [
              FutureBuilder(
                  future: http.read(Uri.parse('$baseURL/api/profile'),
                      headers: {"Authorization": widget.jwt}),
                  builder: (context, snapshot) => snapshot.hasData
                      ? Column(
                          children: <Widget>[
                            Text(
                                "${widget.payload['data']['name']}, here's the data:"),
                            Text(snapshot.data.toString(),
                                style: TextStyle(fontSize: 12))
                          ],
                        )
                      : snapshot.hasError
                          ? Text("An error occurred")
                          : CircularProgressIndicator()),
              ElevatedButton(
                  onPressed: () {
                    storage.delete(key: "jwt");

                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ));
                  },
                  child: Text("Logout"))
            ],
          ),
        ), */
      );
}
