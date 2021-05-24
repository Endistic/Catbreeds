import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paiduaikanmai/model/catdetail_model.dart';
import 'package:paiduaikanmai/model/catmodel.dart';
import 'package:http/http.dart' as http;
import 'package:paiduaikanmai/screen/home.dart';

class Cat extends StatefulWidget {
  final String name;
  final String url_ex;
  Cat({Key key, this.name, this.url_ex}) : super(key: key);

  @override
  _CatState createState() => _CatState(name, url_ex);
}

class _CatState extends State<Cat> {
  final String name;
  final String url_ex;
  _CatState(this.name, this.url_ex);
  @override
  @override
  void initState() {
    print(name);
    print(url_ex);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 500.0,
                    child: FutureBuilder<List<CatDetail>>(
                      future: catselect.getDetail(name),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<CatDetail> catdata = snapshot.data;
                          return ListView(
                            children: <Widget>[
                              new Container(
                                child: Text(
                                  catdata.single.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 24.0),
                                ),
                              ),
                              new SizedBox(
                                height: 8.0,
                              ),
                              new Container(
                                child: Image.network(url_ex),
                              ),
                              ListTile(
                                title: Text("ID : " + catdata.single.id),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              ListTile(
                                title: Text("Description: " +
                                    catdata.single.description),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              ListTile(
                                title:
                                    Text("Origin : " + catdata.single.origin),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ],
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    )),
                _catback(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _catback() {
    return Container(
      child: ElevatedButton(
          child: Container(
              child: Text('Back !!'),
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)))),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ));
          }),
    );
  }
}

class catselect {
  static Future<List<CatDetail>> getDetail(String name) async {
    final url = "https://api.thecatapi.com/v1/breeds/search?name=$name";
    var response = await http.get(
      Uri.parse(url),
      headers: {"x-api-key": "8b7fd9d2-d9f7-4aa5-8a87-857e1e32ccc8"},
    );
    List jsonData = json.decode(response.body);
    return jsonData.map((catx) => new CatDetail.fromJson(catx)).toList();
  }
}
