import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/admin/home_admin.dart';
import 'package:shoppingapp/widget/support_widget.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller=new TextEditingController();
    TextEditingController passwordcontroller=new TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40,left: 20,right: 20,bottom: 40.0),
          child: 
            //key: _formkey,
           Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/image.png"),
                Center(
                  child: Text("Admin Panel",style: AppWidget.semiboldTextFieldStyle(),),
                ),
                SizedBox(height: 20.0,),
                Text("Please enter the details below to\n                      continue.",style: AppWidget.lightTextFieldStyle(),),
                SizedBox(height: 40.0,),
                Text("User Name",style: AppWidget.semiboldTextFieldStyle(),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    
                    controller: usernamecontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 111, 10, 179), width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),),
                      hintText: "User Name"
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
                   loginAdmin();
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
               
                    
                
                
            
            ],),
          ),
        ),
      );
     
    
  }
  loginAdmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
      snapshot.docs.forEach((result){
        if(result.data()['username']!=usernamecontroller.text.trim()){
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Your ID is not correct",style: TextStyle(fontSize: 20),)));
        }
        else if(result.data()['password']!=passwordcontroller.text.trim()){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Provided password is not correct",style: TextStyle(fontSize: 20),)));
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeAdmin()));
        }
      });
    });
  }
}