import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/pages/bottom_nav.dart';
//import 'package:shoppingapp/pages/home.dart';
import 'package:shoppingapp/pages/login.dart';
import 'package:shoppingapp/services/database.dart';
import 'package:shoppingapp/services/shared_pref.dart';
import 'package:shoppingapp/widget/support_widget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? name,email,password ;
  TextEditingController namecontroller= new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController passwordcontroller= new TextEditingController();
  final _formkey=GlobalKey<FormState>();
  registration()async{
   
    if(password!=null && name!=null && email!=null){
      print("ncnrc");
      try {
        UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
        print("helllpp");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Registered Succeddfully",style: TextStyle(fontSize: 20),)));
          String Id=randomAlphaNumeric(10);
          await SharedPref().saveUserEmail(emailcontroller.text);
           await SharedPref().saveUserId(Id);
           await SharedPref().saveUserName(namecontroller.text);
           await SharedPref().saveUserImage("https://images.app.goo.gl/KVxAS8XXQ9WwL1k38");
          Map<String,dynamic> userInfoMap={
            "Name":namecontroller.text,
            "Email":emailcontroller.text,
            "Id":Id,
            "Image":"https://images.app.goo.gl/KVxAS8XXQ9WwL1k38"
          };
          await DatabaseMethods().addUserDetails(userInfoMap, Id);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav()));

        
      }on FirebaseException catch (e) {
          
        if(e.code=='weak-password'){

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Provided password is weak",style: TextStyle(fontSize: 20),)));
          
        }
        else if(e.code=='email-already-in-use'){

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Account already exists",style: TextStyle(fontSize: 20),)));
        }
        
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40,left: 20,right: 20,bottom: 40.0),
          child: Form(
            key: _formkey,
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/image.png"),
                Center(
                  child: Text("Sign Up",style: AppWidget.semiboldTextFieldStyle(),),
                ),
                SizedBox(height: 20.0,),
                Text("Please enter the details below to\n                      continue.",style: AppWidget.lightTextFieldStyle(),),
                SizedBox(height: 40.0,),
                Text("Name",style: AppWidget.semiboldTextFieldStyle(),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "Please Enter your name";

                      }
                      return  null;
                    },
                    controller: namecontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 111, 10, 179), width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),),
                      hintText: "Name"
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Text("Email",style: AppWidget.semiboldTextFieldStyle(),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "Please Enter your email";

                      }
                      return  null;
                    },
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 111, 10, 179), width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),),
                      hintText: "Email"
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                 Text("Password",style: AppWidget.semiboldTextFieldStyle(),),
                 SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "Please Enter your password";

                      }
                      return  null;
                    },
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 111, 10, 179), width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
            ),
                      hintText: "Password"
                    ),
                  ),
                ),
               
                
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        name=namecontroller.text;
                        email=emailcontroller.text;
                        password=passwordcontroller.text;
                      });
                    }
                    print("hey");
                    registration();
                  },
                  child: Center(  
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(color:Color.fromARGB(255, 111, 10, 179),borderRadius: BorderRadius.circular(10) ),
                      child: Center(child: Text("SignUp",style :TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold))),
                      ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Already have an account? ",style: AppWidget.lightTextFieldStyle(),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Text("Login",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                ],)
                    
                
                
            
            ],),
          ),
        ),
      ),
    );
  }
}