import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/pages/onboarding.dart';
import 'package:shoppingapp/services/auth.dart';
import 'package:shoppingapp/services/shared_pref.dart';
import 'package:shoppingapp/widget/support_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String ? image,name,email;

  getthesharedpref()async{
    image=await SharedPref().getUserImage();
    name=await SharedPref().getUserName();
    email=await SharedPref().getUserEmail();
    setState(() {
      
    });

  }
  @override
  void initState(){
    getthesharedpref();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: AppBar(
       backgroundColor:  Color.fromARGB(255, 217, 216, 220),

        title: Text("Profile",style: AppWidget.boldTextFieldStyle(),),),
      backgroundColor: Color.fromARGB(255, 217, 216, 220),
      body:  name== null ?   Center(child: CircularProgressIndicator()): Container(
        child: Column(children: [
        Center(
          
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Image.asset("images/boy.jpg",
            height: 150,
            width: 150,
            fit: BoxFit.cover,),
          ),
        ),
        SizedBox(height: 20,),
        Container(
          
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                Icon(Icons.person_2_outlined,size: 35,),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start  ,
                  children: [

            
                    Text("Name",style: AppWidget.lightTextFieldStyle(),),
                    Text(name!,style: AppWidget.semiboldTextFieldStyle(),),
                    
                  ],
                )
              ],),
              
            ),
          ),
        ),
        SizedBox(height: 20,),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Container(

              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                Icon(Icons.email_outlined,size: 35,),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start  ,
                  children: [

            
                    Text("Email",style: AppWidget.lightTextFieldStyle(),),
                    Text(email!,style: AppWidget.semiboldTextFieldStyle(),),
                    
                  ],
                )
              ],),
              
            ),
          ),
        ),
        SizedBox(height: 20,),
        GestureDetector(
          onTap: ()async{
            await AuthMethods().SignOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder:(context) => Onboarding(),));
            });
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  Icon(Icons.login,size: 35,),
                  SizedBox(width: 10,),
                  Text("LogOut",style: AppWidget.semiboldTextFieldStyle(),),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_outlined)
                  
                ],),
                
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        GestureDetector(
          onTap: ()async{
            await AuthMethods().deleteUser().then((value){
              Navigator.push(context, MaterialPageRoute(builder:(context) => Onboarding(),));
            });
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  Icon(Icons.delete_outline,size: 35,),
                  SizedBox(width: 10,),
                  Text("Delete Account",style: AppWidget.semiboldTextFieldStyle(),),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_outlined)
                  
                ],),
                
              ),
            ),
          ),
        )
      ],),),


    );
  }
}