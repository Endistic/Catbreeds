import 'dart:convert';
import 'package:flutter/src/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paiduaikanmai/model/catmodel.dart';
import 'package:paiduaikanmai/screen/cat.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<CatModel> futureCat;

  @override
  void initState() {
    super.initState();
  }

  var selectList = -1;
  String name;
  String url_ex;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40.0,
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    "Cat Breed",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: 475,
                  child: FutureBuilder<List<CatModel>>(
                    future: catService.randomCat(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<CatModel> catdata = snapshot.data;
                        return ListView.builder(
                          itemCount: catdata.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (catdata[index].image != null) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectList = index;
                                    if (selectList != -1) {
                                      name = catdata[index].name;
                                      url_ex = catdata[index].image.url;
                                      print(name);
                                      print(url_ex);
                                    } else {
                                      print("Please Select");
                                    }
                                  });
                                },
                                child: Container(
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: (selectList == index)
                                        ? RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.amber,
                                                width: 5.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )
                                        : null,
                                    elevation: 8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Container(
                                          child:
                                              catdata[index].image.url != null
                                                  ? Image.network(
                                                      catdata[index].image.url,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Container(
                                                      child: Text("Error"),
                                                    ),
                                          // child: Image.network(
                                          //   catdata[index].image.url,
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        new Divider(
                                          height: 5.0,
                                        ),
                                        new Container(
                                          child: Text(
                                            "Name of Cat : " +
                                                catdata[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        new Container(
                                          child: Text(
                                            "Weight of Cat: " +
                                                catdata[index].weight.imperial +
                                                "kg",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  setState(() {
                                    selectList = index;
                                    if (selectList != -1) {
                                      name = catdata[index].name;
                                      print(name);
                                    } else {
                                      print("Please Select");
                                    }
                                  });
                                });
                              },
                              child: Container(
                                child: Card(
                                  color: Colors.green[200],
                                  clipBehavior: Clip.antiAlias,
                                  shape: (selectList == index)
                                      ? RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.amber),
                                          borderRadius:
                                              BorderRadius.circular(10.0))
                                      : null,
                                  elevation: 8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                        child: Text("Not Picture"),
                                      ),
                                      new Container(
                                        child: Text(
                                          "Name of Cat : " +
                                              catdata[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      new Container(
                                        child: Text(
                                          "Weight of Cat: " +
                                              catdata[index].weight.imperial +
                                              "kg",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
                _catbutton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _catbutton() {
    return Container(
      child: ElevatedButton(
          child: Container(
              child: Text('CAT  Select!!'),
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)))),
          onPressed: () {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Cat(
                        name: name,
                        url_ex: url_ex,
                      )));
            });
          }),
    );
  }
}

class catService {
  static Future<List<CatModel>> randomCat() async {
    var url = "https://api.thecatapi.com/v1/breeds";
    var response = await http.get(
      Uri.parse(url),
      headers: {"x-api-key": "8b7fd9d2-d9f7-4aa5-8a87-857e1e32ccc8"},
    );
    List jsonData = json.decode(response.body);
    return jsonData.map((catx) => new CatModel.fromJson(catx)).toList();
  }
}
