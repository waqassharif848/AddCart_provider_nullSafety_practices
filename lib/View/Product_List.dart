import 'package:addcart_provider_nullsafety/Model/Cart_model.dart';
import 'package:addcart_provider_nullsafety/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:provider/provider.dart';

import '../ViewModel/Cart_Provider.dart';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  DbHelper? dbHelper= DbHelper();

  List<String> productName = ['Mango' , 'Orange' , 'Grapes' , 'Banana' , 'Chery' , 'Peach','Mixed Fruit Basket',] ;
  List<String> productUnit = ['KG' , 'Dozen' , 'KG' , 'Dozen' , 'KG' , 'KG','KG',] ;
  List<int> productPrice = [10, 20 , 30 , 40 , 50, 60 , 70 ] ;
  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg' ,
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg' ,
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg' ,
    'https://jooinn.com/images/banana-7.jpg' ,
    'https://www.erdbeer.com/wp-content/uploads/2022/07/iStock_000010021990Medium.jpg' ,
    'https://media.istockphoto.com/photos/single-peach-fruit-with-half-isolated-on-white-picture-id1129917336?k=6&m=1129917336&s=170667a&w=0&h=RF4pVkSw6JuYAKFz4SzBOH0Fzfewjzjkz2zwoo9sC2g=' ,
    'https://asset.bloomnation.com/c_pad,d_vendor:global:catalog:product:image.png,f_auto,fl_preserve_transparency,q_auto/v1623555578/vendor/2602/catalog/product/2/0/20180528101419_file_5b0c7f3b650d6.jpg' ,
  ] ;

  @override
  Widget build(BuildContext context) {
    final cart= Provider.of<ChartProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Product List"),
          actions: [
            Center(
              child: badge.Badge(
                badgeAnimation: badge.BadgeAnimation.slide(
                  toAnimate: true,
                  animationDuration: Duration(
                    milliseconds: 100,
                  )
                ),
                badgeContent: Consumer<ChartProvider>(
                    builder: (context,value, child){
                      return Text(value.getCounter().toString(), style: TextStyle(color: Colors.white),);
                    },

                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
            )],
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: productName.length  ,
                    itemBuilder:(context,index){
                      return Card(
                        child:Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(productImage[index].toString()) ),
                                  SizedBox(width: 10,),
                                 Expanded(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(productName[index].toString(),
                                         style: TextStyle(fontSize: 18, fontWeight:FontWeight.w600 ),),
                                       SizedBox(height: 5,),
                                       Text(productPrice[index].toString()+r"$"+"  "+"Per"+"  "+productUnit[index].toString(),
                                         style: TextStyle(fontSize: 16, fontWeight:FontWeight.w400 ),),

                                       Align(
                                         alignment: Alignment.centerRight,
                                         child: InkWell(
                                           onTap: (){
                                             dbHelper!.insert(
                                               Cart(
                                                   id: index,
                                                   productId: index.toString(),
                                                   productName: productName[index].toString(),
                                                   initialPrice: productPrice[index],
                                                   productPrice: productPrice[index],
                                                   quantity: 1,
                                                   unitTag: productUnit[index].toString(),
                                                   image: productImage[index].toString())
                                             ).then((value){
                                               cart.addtotalPrice(double.parse(productPrice[index].toString()));
                                               cart.addCounter();
                                               print('Product is added to cart');
                                             }).onError((error,stackTrace){
                                               print(error.toString());
                                             } );
                                           },
                                           child: Container(
                                             height: 30,
                                             width: 100,
                                             decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(10),
                                               color: Colors.deepPurple,
                                             ),
                                             child: Center(
                                               child: Text('Add to Cart', style: TextStyle(color: Colors.white),),
                                             ),
                                           ),
                                         ),
                                       )
                                     ],
                                   ),
                                 )
                                ],
                              )
                            ],
                          ),
                        ) ,
                      );
                    }
                ),
            )
          ],
        ),
      ),
    );
  }
}
