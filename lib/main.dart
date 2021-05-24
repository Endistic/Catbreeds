import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paiduaikanmai/screen/cat.dart';
import 'package:paiduaikanmai/screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Endy Wallet',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: Home());
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: 0,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Cat Profile"),
//           centerTitle: true,
//           actions: <Widget>[
//             IconButton(
//                 icon: const Icon(Icons.menu),
//                 onPressed: () {
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(const SnackBar(content: Text("History")));
//                 }),
//           ],
//         ),
//         body: TabBarView(
//           children: <Widget>[
//             new Home(),
//             new Cat(),
//           ],
//         ),
//         bottomNavigationBar: TabBar(
//           labelColor: Colors.pink,
//           labelPadding: EdgeInsets.all(5),
//           indicatorColor: Colors.blue,
//           indicatorWeight: 5,
//           indicatorSize: TabBarIndicatorSize.tab,
//           unselectedLabelColor: Colors.black,
//           labelStyle: TextStyle(
//               fontFamily: 'RaleWay', fontSize: 16, fontWeight: FontWeight.bold),
//           tabs: <Widget>[
//             Tab(
//               icon: Icon(Icons.home),
//             ),
//             Tab(
//               text: "CAT",
//             ),
//           ],
//         ),
//       ),
//       length: 2,
//     );
//   }
// }
