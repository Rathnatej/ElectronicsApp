import 'package:flutter/material.dart';
import 'package:shoppingapp/admin/add_product.dart';
import 'package:shoppingapp/admin/all_orders.dart';
import 'package:shoppingapp/widget/support_widget.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: AppBar(
       backgroundColor:  Color.fromARGB(255, 217, 216, 220),

        title: Text("Admin Profile",style: AppWidget.boldTextFieldStyle(),),),
      backgroundColor: Color.fromARGB(255, 217, 216, 220),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),  
        child: Column(
          children: [
            SizedBox(height: 50,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
              },
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:  EdgeInsets.only(top: 10,bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    children: [
                    Icon(Icons.add,size: 50,),
                    SizedBox(width: 20,),
                    Text("Add Product",style: AppWidget.boldTextFieldStyle(),)
                  ],)
                
                  
                ),
              ),
            ),
            SizedBox(height: 80,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AllOrders()));
              },
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:  EdgeInsets.only(top: 10,bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    children: [
                    Icon(Icons.shopping_bag_outlined,size: 50,),
                    SizedBox(width: 20,),
                    Text("All Orders",style: AppWidget.boldTextFieldStyle(),)
                  ],)
                
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}