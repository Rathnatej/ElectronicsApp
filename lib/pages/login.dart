import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/pages/bottom_nav.dart';
import 'package:shoppingapp/pages/home.dart';
import 'package:shoppingapp/pages/signup.dart';
import 'package:shoppingapp/widget/support_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email="", password="";

  TextEditingController mailcontroller=new TextEditingController();
  TextEditingController passwordcontroller= new TextEditingController();
  final _formkey=GlobalKey<FormState>();
  userLogin()async{
    try {
      print("fjo");
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav()));
      
    } on FirebaseAuthException catch (e) {
      if(e.code=='user-not-found'){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("User Does not exist",style: TextStyle(fontSize: 20),)));
      }
      else if(e.code=='wrong-password'){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Wrong password",style: TextStyle(fontSize: 20),)));
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
                  child: Text("Sign In",style: AppWidget.semiboldTextFieldStyle(),),
                ),
                SizedBox(height: 20.0,),
                Text("Please enter the details below to\n                      continue.",style: AppWidget.lightTextFieldStyle(),),
                SizedBox(height: 40.0,),
                Text("Email",style: AppWidget.semiboldTextFieldStyle(),),
                SizedBox(height: 20.0,),
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
                    controller: mailcontroller,

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
                 SizedBox(height: 20.0,),
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
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  Text("Forgot Password ?",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                ],),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        email=mailcontroller.text;
                        password=passwordcontroller.text;
                      });
                    }
                    userLogin();
                  },
                  child: Center(  
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(color:Color.fromARGB(255, 111, 10, 179),borderRadius: BorderRadius.circular(10) ),
                      child: Center(child: Text("LOGIN",style :TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold))),
                      ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Don't have an account? ",style: AppWidget.lightTextFieldStyle(),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                    },
                    child: Text("Sign Up",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                ],)
                    
                
                
            
            ],),
          ),
        ),
      ),
    );
  }
}