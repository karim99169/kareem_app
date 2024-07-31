import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:superscanner/add_a_product_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List data=[];
Future<void> fetchData(String result) async {
    const url = 'http://192.168.88.253/getData.php'; 

    try {
      final response = await http.get(Uri.parse(
        '$url?scanNum=$result', // Sending only scanNum parameter
      ));
      print(response.statusCode);

      if (response.statusCode == 200) {
        try {
          List<dynamic> data1=json.decode(response.body);
          print(data1);
          setState(() {
            data=data1;
          });
        } catch (e) {
          print('Error decoding JSON: $e');
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  String? result;
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: Text('SuperScanner',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),actions: [
        IconButton(icon:const  Icon(Icons.add),onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddProductPage()));
        },),
      ],),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          result!=null?    Expanded(child: ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) {
                return ListTile(
   title: Text(data[index]["title"].toString() , style: TextStyle(
     color: Colors.white
   ),),
   trailing: Text(data[index]['price']+'\$' ,style: TextStyle(
       color: Colors.white
   ),),
);
              }))):
              
               Text('Scan to get the product',style: GoogleFonts.poppins(fontSize: 17,backgroundColor: Colors.blue)),


              //Text(data[0]['title']),
              const Spacer(),
              const  Spacer(),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
              minimumSize: const Size(300,70),
              backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
               onPressed: () async{
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SimpleBarcodeScannerPage(),
                        ));
                    setState(() {
                      if (res is String) {
                        result = res;
                           setState(() {
                            
                          });
                       
                      }
                                  fetchData(result!);

                    
                    });
              
            }, child: const  Text('Scan a product')),
          ],),
        ),
      )
    );
  }
}


