import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../menu/drawer.widget.dart';

class Paysdetails extends StatefulWidget {
  String pays;
  Paysdetails(this.pays);


  @override
  State<Paysdetails> createState() => _PaysdetailsState();
}


class _PaysdetailsState extends State<Paysdetails> {
  @override
  void initState() {
    super.initState();
    getPaysData(widget.pays);
  }

  var paysData;
  var data;
  void getPaysData(String pays) {
    print("pays details " + pays);
    String url = "https://restcountries.com/v2/name/${pays}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.paysData = json.decode(utf8.decode(resp.bodyBytes));
        data = paysData[0];
        print(this.paysData);
      });
    }).catchError((err) {
      print(err);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Pays Details${data['name']}'),
        backgroundColor: Colors.blue,
      ),
      body: (data!=null?Column(
        children: [
          Image(image: NetworkImage("${data['flags']['png']}")),
          SizedBox(
            height: 16,
          ),
          Column(
            children: [
              Text(
                "${data['name']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data['nativeName']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Administration",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("capital :"),
                  Text("${data['capital']}"),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Language(s):"),
                  Text(
                      "${data['languages'][0]['name']}+${data['languages'][0]['nativeName']}"),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Géographie",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Région :"),
                  Text("${data['region']}"),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Superficie:"),
                  Text("${data['area']}"),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Fuseau Horaire:"),
                  Text("${data['timezones'][0]}"),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Démographie",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("population:"),
                  Text("${data['population']}"),
                ],
              ),
            ],
          )
        ],
      ):Center(
        child: CircularProgressIndicator(),
      )),
    );
  }


}
