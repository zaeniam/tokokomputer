import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas1/produk.dart';
import './beranda.dart' as beranda;
import './produk.dart' as produk;
import 'login/auth.dart';
import 'login/auth1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Auth(),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController controller; //widget untuk tabbar
  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new beranda.beranda(), // manggil kelas beranda inget import kelasnya dulu diatas
          Produk(),
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.deepPurple,
        child: new TabBar(controller: controller, tabs: <Widget>[
          // widget tabs biar bisa ngisiin isi tabnya
          new Tab(icon: new Icon(Icons.home)),
          new Tab(
            icon: new Icon(Icons.list),
          ),
        ]),
      ),
    );
  }
}
