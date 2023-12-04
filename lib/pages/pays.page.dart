import 'package:flutter/material.dart';
import 'package:voyage/pages/pays-details.page.dart';

import '../menu/drawer.widget.dart';

class PaysPage extends StatelessWidget {

  TextEditingController txt_pays=new TextEditingController();
  void _OnGetMeteoDetails(BuildContext context){
    String v=txt_pays.text;
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>Paysdetails(v)));
    txt_pays.text="";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Page Pays")),
      drawer: MyDrawer(),
      body: Center(
          child:Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: txt_pays,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      hintText: "Pays",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ), onPressed: () { _OnGetMeteoDetails(context); },
                  child: Text("chercher"),
                ),
              ),
            ],
          )
      ),
    );
  }
}
