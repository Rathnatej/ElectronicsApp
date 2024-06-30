import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/pages/product_details.dart';
import 'package:shoppingapp/services/database.dart';
import 'package:shoppingapp/widget/support_widget.dart';

class CategoryProducts extends StatefulWidget {
  String category;
  CategoryProducts({required this.category});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  Stream? CatergoryStream;
  getontheLoad()async{
    CatergoryStream =await DatabaseMethods().getProducts(widget.category);
    setState(() {
      
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getontheLoad();
    super.initState();
  }

  Widget allProducts(){
    return StreamBuilder(stream: CatergoryStream, builder: (context,AsyncSnapshot snapshot){
      return snapshot.hasData? GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6,mainAxisSpacing:10,crossAxisSpacing: 10 ),itemCount: snapshot.data.docs.length, itemBuilder: (context,index){
          DocumentSnapshot ds=snapshot.data.docs[index];
          return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10)  ,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  child:  Column(children: [
                    SizedBox(height: 10,),
                    Image.network(ds["Image"],height: 150,width: 150,  fit: BoxFit.cover,),
                    SizedBox(height: 10,),
                    Text(ds["Name"],style: AppWidget.semiboldTextFieldStyle(),),
                    Spacer(),
                    Row(children: [
                      
                      Text("\$"+ds["Price"],style: TextStyle(color: Color.fromARGB(255, 111, 10, 179),fontSize:22.0,fontWeight: FontWeight.bold),),
                      SizedBox(width: 30.0,),
                      GestureDetector(
                        onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(name: ds["Name"], image: ds["Image"], price: ds["Price"], detail: ds["Detail"])));
                  },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Color.fromARGB(255, 111, 10, 179),borderRadius: BorderRadius.circular(7) ),
                          child:Icon(
                            Icons.add,color: Colors.white,
                          ) ,
                        ),
                      )
                    ],)
                  ],),
                );
        }):Container();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 217, 216, 220),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 217, 216, 220),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: Column(children: [
            Expanded(child: allProducts()),
        ],),
      ),
    );
  }
}