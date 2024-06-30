import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/services/database.dart';
import 'package:shoppingapp/widget/support_widget.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {

  Stream? orderStream;


getontheLoad()async{
  orderStream=await DatabaseMethods().allOrders();
  setState(() {
    
  });

}
@override
void initState(){
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
                        Text("Name:"+ds["Name"],
                    style:TextStyle(color: Color.fromARGB(255, 1, 106, 19),fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(ds["Email"],
                    style:AppWidget.lightTextFieldStyle()),
                        Text("\$"+ds["Price"],
                    style:TextStyle(color: Color.fromARGB(255, 111, 10, 179),fontSize: 23,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,), 
                    GestureDetector(
                      onTap: ()async{
                        await DatabaseMethods().updateStatus(ds.id);
                        setState(() {
                          
                        });

                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        width: 150,
                        decoration: BoxDecoration(color :Color.fromARGB(255, 46, 218, 120) ,
                        borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("Done",style: AppWidget.semiboldTextFieldStyle(),)),
                      ),
                    )
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
      appBar: AppBar(title: Text("All Orders",style: AppWidget.boldTextFieldStyle(),),),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: Column(children: [
            Expanded(child: allOrders()),
        ],),
      ),
    );
  }
}