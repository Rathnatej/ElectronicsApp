import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/services/database.dart';
import 'package:shoppingapp/services/shared_pref.dart';
import 'package:shoppingapp/widget/support_widget.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  String? email;
  getthesharedpref()async{
    email=await SharedPref().getUserEmail();
   
    setState(() {});
    }   
  Stream? orderStream;

  getontheLoad()async {
    await getthesharedpref();
    orderStream=await DatabaseMethods().getOrders(email!);
    setState(() {
      
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    getontheLoad();
    super.initState();
  }

Widget allOrders(){
    return StreamBuilder(stream: orderStream, builder: (context,AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
        //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6,mainAxisSpacing:10,crossAxisSpacing: 10 ),
        itemCount: snapshot.data.docs.length, itemBuilder: (context,index){
          DocumentSnapshot ds=snapshot.data.docs[index];
          return Container(
            margin: EdgeInsets.only( bottom: 20),
            child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              
              padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
              width:  MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: 
                Row(children: [
                  Image.network(ds["ProductImage"],height: 120,width: 120,fit: BoxFit.cover,),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ds["Product"],style: AppWidget.semiboldTextFieldStyle(),),
                        Text("\$"+ds["Price"],
                    style:TextStyle(color: Color.fromARGB(255, 111, 10, 179),fontSize: 25,fontWeight: FontWeight.bold),),
                    Text("Status: "+ds["Status"],
                    style:TextStyle(color: Color.fromARGB(255, 222, 136, 16),fontSize: 18,fontWeight: FontWeight.bold),),
                    
                      ],
                                
                    ),
                  )
                ],)
              
            ),
                    ),
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
        title: Text("Current orders",style:AppWidget.boldTextFieldStyle()),),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20 ),
        child:
       Column(
        children: [
          Expanded(child: allOrders()),

      ],),),
    );


  }
}