import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'View/Product_List.dart';
import 'ViewModel/Cart_Provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=> ChartProvider(),
        child: Builder(builder: (BuildContext context){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              // useMaterial3: true,
            ),
            home: ProductListScreen(),
          );
    }),
    );
  }
}
