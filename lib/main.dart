import 'package:flutter/material.dart';
import 'package:machine_code/pages/menu_list_page.dart';
import 'package:machine_code/provider/order_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => OrderProvider())],
          child: const MenuListPage()),
    );
  }
}
