import 'package:flutter/material.dart';
import 'package:voyage/menu/drawer.widget.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'gallery-details.page.dart';

class GalleriePage extends StatelessWidget {
  final TextEditingController txt_gallerie = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Gallerie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: txt_gallerie, // Added this line
              decoration: InputDecoration(
                prefixIcon: Icon(MaterialCommunityIcons.image_multiple,
                    size: 30, color: Colors.blue),
                hintText: "Keyword",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String keyword = txt_gallerie.text;
                _onGetGallerieDetails(context);
              },
              child: Text('Chercher', style: TextStyle(fontSize: 22)),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onGetGallerieDetails(BuildContext context) {
    String keyword = txt_gallerie.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GallerieDetailPage(keyword),
      ),
    );
  }
}
