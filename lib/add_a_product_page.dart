import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart'as http;
import 'package:superscanner/variables.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {


  Future<void> sendData(String barcode, String title, String price) async {
    const url = 'http://192.168.88.253/updateSuccess.php';

    try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'scanNum': result,
        'title': title,
        'price': price,
      },
    );
    print(response);

    
  } catch (e) {
    print('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:  Text('ADD A PRODUCT PAGE',style: GoogleFonts.poppins(color:Colors.black),),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor:Colors.white),
        body: Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              const  Spacer(),
        
               InkWell(
          onTap: ()async{
            var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SimpleBarcodeScannerPage(),
                          ));
                      setState(() {
                        if (res is String) {
                          result = res;
                          print(result);
                       
                        }
                      });
          },
          child: Container(height: 80,width: 200,decoration: BoxDecoration(color: Colors.grey.shade100,border: Border.all(color: Colors.grey,),borderRadius: BorderRadius.circular(10)),
          
          child:const  Center(child:  Text(" scan to Get barcode number")),
          ),
              ),

                const SizedBox(height: 20,),
                TextField(
                controller: titleController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "enter product title",border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),),
               
               const SizedBox(height: 20,),
                TextField(
                  style: TextStyle(color: Colors.white),
                controller: priceController,
                decoration: const InputDecoration(labelText: "enter price",border:OutlineInputBorder(borderSide:BorderSide(color: Colors.blue))),keyboardType: TextInputType.number,)
        
        
     ,   const Spacer(),

     ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: const Size(250,50),),
      onPressed: ()async{
      await  sendData(result, titleController.text  , priceController.text);

      titleController.clear();
      priceController.clear();
      result='';
      
         Navigator.pop(context);
      }, child:  Text('SAVE',style: GoogleFonts.poppins(),),),

              ],),
        )),
    );
  }
}