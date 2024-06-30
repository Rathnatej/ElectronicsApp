import 'dart:ffi';
//import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/pages/category_products.dart';
import 'package:shoppingapp/pages/product_details.dart';
import 'package:shoppingapp/services/database.dart';
import 'package:shoppingapp/services/shared_pref.dart';
import 'package:shoppingapp/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool  search=false;
  List categories=[
    "images/headphone_icon.png",
    "images/laptop.png",
    "images/watch.png",
    "images/TV.png"

  ];
  List Categoryname =[
    "HeadPhones",
    "Laptop",
    "Watch",
    "TV",
  ];
  var queryResultSet=[];
  var tempSearchStore=[];
  TextEditingController searchcontroller=new TextEditingController();

  initiateSearch(value){
    if(value.length==0){
      setState(() {
        queryResultSet=[];
        tempSearchStore=[];
      });
    }
    setState(() {
      search=true;
    });
    var capitalisedValue=value.substring(0,1).toUpperCase()+value.substring(1);
    if(queryResultSet.isEmpty && value.length==1){
       DatabaseMethods().search(value).then((QuerySnapshot docs){
        for(int i=0;i<docs.docs.length;++i){
            queryResultSet.add(docs.docs[i].data());
        }

       });
    }else{
      tempSearchStore=[];
      queryResultSet.forEach((element){
        if(element['UpdatedName'].startsWith(capitalisedValue)){
          setState(() {
            tempSearchStore.add(element);
          });

        }
      });
    }
  }
  String ? name,image;
  getthesharedpref()async{
    name=await SharedPref().getUserName();
    image= await SharedPref().getUserImage();
    setState(() {
      
    });
    ontheload()async{
      await getthesharedpref();
      setState(() {});
    }
    @override
    void initState(){
      ontheload();
      super.initState();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 217, 216, 220),
      body: GestureDetector(
        onTap: (){
          
        },
        child: Container(
          
          margin: EdgeInsets.only(top:50.0,left: 20.0,right: 20.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hey, ",
                  style: AppWidget.boldTextFieldStyle(),),
                  Text("Good Mornfing",style: AppWidget.lightTextFieldStyle()),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("images/boy.jpg",height: 80,width: 80,fit: BoxFit.cover,),
              )
              
            ],
          ),
          SizedBox(height: 30.0,),
          Container(
            //padding: EdgeInsets.only(left: 20.0),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: searchcontroller,
              onChanged: (value){
                initiateSearch(value.toUpperCase());
                              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Products",hintStyle: AppWidget.lightTextFieldStyle(),
                prefixIcon: search ? GestureDetector(
                  onTap: (){
                    search=false;tempSearchStore=[];
                    queryResultSet=[];
                    searchcontroller.text=""; 
                    setState(() {
                      
                    });

                  },
                  child: Icon(Icons.close)):
                Icon(Icons.search,color: Colors.black,)
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          search ? ListView(
            padding: EdgeInsets.only(left: 10,right: 10),
            primary: false,
            shrinkWrap: true,
            children: 
              tempSearchStore.map((element){
                return buildresultcard(element);
              }).toList(),
            
            

          )
          : 
           Column(
             children: [
               Padding(
                 padding: const EdgeInsets.only(right: 20),
                 child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Categories",
                      style: AppWidget.semiboldTextFieldStyle(),
                    ),
                    Text("See all",
                      style:TextStyle(color: Color.fromARGB(255, 111, 10, 179),fontSize: 18,fontWeight: FontWeight.w500),
                          
                    )
                    ],
                  ),
               ),
             
          
          SizedBox(height: 20,),
          Row(
            children: [
              Container(
                height: 130,
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration( 
        color :Color.fromARGB(255, 111, 10, 179),borderRadius: BorderRadius.circular(10)),
             
        child:Center(child: Text("ALL",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),))
            ),
              Expanded(
        
                child: Container(height: 130,
                child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: 
                (context,index){
                  return CateogoryTile(image: categories[index],name: Categoryname[index],);
                }),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("All products",
              style: AppWidget.semiboldTextFieldStyle(),
            ),
            Text("See all",
              style:TextStyle(color: Color.fromARGB(255, 111, 10, 179),fontSize: 18,fontWeight: FontWeight.w500),
        
            )
            ],
          ),
          SizedBox(height: 20,),
          Container(
            height: 240,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  child:  Column(children: [
                    Image.asset("images/headphone2.png",height: 150,width: 150,  fit: BoxFit.cover,),
                    Text("Headphones",style: AppWidget.semiboldTextFieldStyle(),),
                    SizedBox(height: 10,),
                    Row(children: [
                      
                      Text("\$100",style: TextStyle(color: Color.fromARGB(255, 111, 10, 179),fontSize:22.0,fontWeight: FontWeight.bold),),
                      SizedBox(width: 50.0,),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Color.fromARGB(255, 111, 10, 179),borderRadius: BorderRadius.circular(7) ),
                        child:Icon(
                          Icons.add,color: Colors.white,
                        ) ,
                      )
                    ],)
                  ],),
                ),
                SizedBox(width: 20.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  child:  Column(children: [
                    Image.asset("images/watch2.png",height: 150,width: 150,  fit: BoxFit.cover,),
                    Text("Apple Watch",style: AppWidget.semiboldTextFieldStyle(),),
                    SizedBox(height: 10,),
                    Row(children: [
                      
                      Text("\$300",style: TextStyle(color: Color.fromARGB(255, 111, 10, 179),fontSize:22.0,fontWeight: FontWeight.bold),),
                      SizedBox(width: 50.0,),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Color.fromARGB(255, 111, 10, 179),borderRadius: BorderRadius.circular(7) ),
                        child:Icon(
                          Icons.add,color: Colors.white,
                        ) ,
                      ),
                      
                    ],)
                  ],),
                ),
                SizedBox(width: 20.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  child:  Column(children: [
                    Image.asset("images/laptop2.png",height: 150,width: 150,  fit: BoxFit.cover,),
                    Text("Laptop",style: AppWidget.semiboldTextFieldStyle(),),
                    SizedBox(height: 10,),
                    Row(children: [
                      
                      Text("\$1000",style: TextStyle(color: Color.fromARGB(255, 111, 10, 179),fontSize:22.0,fontWeight: FontWeight.bold),),
                      SizedBox(width: 50.0,),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Color.fromARGB(255, 111, 10, 179),borderRadius: BorderRadius.circular(7) ),
                        child:Icon(
                          Icons.add,color: Colors.white,
                        ) ,
                      )
                    ],)
                  ],),
                )
        
              ],
            ),
          )
        
        
        
          
          
        ],),
        ],
           ),),
      ),
    );
    
  }
  Widget buildresultcard(data){
    return GestureDetector(
      onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(name: data["Name"], image: data["Image"], price: data["Price"], detail: data['Detail'])));
      },
      child: Container(
        padding: EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration
        (color: Colors.white),
        height: 100,
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(data["Image"],height: 70,width: 70,fit: BoxFit.cover,)),
            SizedBox(width: 20,),
      
          Text(data["Name"],style: AppWidget.semiboldTextFieldStyle() ,)
        ],),
      ),
    );
  }
}

class CateogoryTile extends StatelessWidget {
  String image,name;
  CateogoryTile({required this.image,required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryProducts(category: name)));
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration( 
        color :Colors.white,borderRadius: BorderRadius.circular(10)),
        height: 90,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Image.asset(image,height: 50,width: 50,fit: BoxFit.cover,),
          SizedBox(height: 10.0,),
          Icon(Icons.arrow_forward)
      
        ],),
      ),
    );

  }
  

}