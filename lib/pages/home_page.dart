import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String stringResponse = "";
Map? mapResponse;
Map? dataResponse;
List? listResponse;

class _HomePageState extends State<HomePage> {
  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
        mapResponse = jsonDecode(response.body);
        listResponse = mapResponse?['data'];
      });
    }
  }

  @override
  void initState() {
    apiCall();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API DEMO"),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(20)),
          child: Center(child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                   children: [
                    Image.network(listResponse?[index]['avatar']),
                    Text("${listResponse?[index]['id']??index}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  
                    Text("${listResponse?[index]['email']??"hello@gamil.com"}",style: TextStyle(color: Colors.white,fontSize: 13),),
                    Text("${listResponse?[index]['first_name']??index}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                   ],
                ),
              );
            },
            itemCount: listResponse==null?0:listResponse?.length,
          )),
        ),
      ),
    );
  }
}
