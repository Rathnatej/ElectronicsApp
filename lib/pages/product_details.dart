import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/services/constant.dart';
import 'package:shoppingapp/services/database.dart';
import 'package:shoppingapp/services/shared_pref.dart';
import 'package:shoppingapp/widget/support_widget.dart';
import 'package:http/http.dart' as http;
class ProductDetails extends StatefulWidget {
  String image,name,detail,price;
  ProductDetails({required this.name,required this.image,required this.price,required this.detail});


  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? name,mail,image; 
  getthesharedpref()async{
    name=await SharedPref().getUserName();
    print(name);
    mail=await SharedPref().getUserEmail(); 
    image=await SharedPref().getUserImage();
    setState(() {
      
    });
  }
    ontheload()async{
      await getthesharedpref();
      setState(() {
         
      });
    }
  

  @override
  void initState(){
    super.initState();
    ontheload();
  }
  Map<String,dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
               GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20.0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(30)),
                  child: Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
              Center(child:  Image.network(widget.image ,height: 400,)),
          
          Expanded(child: 
          Container(
            padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
            decoration: BoxDecoration(
             
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
            ),
            width: MediaQuery.of(context).size.width,child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.name,style: AppWidget.boldTextFieldStyle(),),
                    Text("\$"+widget.price,
                style:TextStyle(color: Color.fromARGB(255, 111, 10, 179),fontSize: 25,fontWeight: FontWeight.bold),
                
                          ),
                  ],
                ),
                SizedBox(height: 20,),
                Text("Details",style: AppWidget.semiboldTextFieldStyle(),),
                SizedBox(height: 10,),
                Text(widget.detail),
                SizedBox(height: 60,),
                GestureDetector(
                  onTap: ()  {
                    makePayment(widget.price);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 111, 10, 179),
                      borderRadius: BorderRadius.circular(10),
                       
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text("Buy Now",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                  ),
                )

              ],
            ),
          ))
       

      ],),),
    );
  }

Future<void> makePayment(String amount)async{
  try{
    paymentIntent=await CreatePaymentIntent(amount,'INR');
    await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntent?['client_secret'],
      style: ThemeMode.dark,merchantDisplayName: 'Rathna',
    )).then((value){});
     displayPaymentSheet(amount);
  }catch(e,s){
    print('My error :$e$s');
  }
}


displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        Map<String,dynamic> orderInfoMap={
            "Product":widget.name,
            "Price":widget.price,
            "Name":name,
            "Email":mail,
            "Image":image,
            "ProductImage":widget.image,
            "Status":"On the way",
        };
        await DatabaseMethods().orderDetails(orderInfoMap);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
                //await getthesharedpref();
  

        paymentIntent = null;

      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }
CreatePaymentIntent(String amount,String currency)async{
  try{
    Map<String,dynamic> body={
      'amount':calculateAmount(amount),
      'currency':currency,
      'payment_method_types[]':'card'
    };
    var response=await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents')
    ,headers:{
      'Authorization':'Bearer $secretkey'
    ,'Content-Type':'application/x-www-form-urlencoded'}
    ,body: body,
    );
    return jsonDecode(response.body);
  }catch(e){
    print("err charging user:${e.toString()}");
  }
}
calculateAmount(String amount){
  final calculatedAmount=(int.parse(amount)*100);
  return calculatedAmount.toString();
}

}