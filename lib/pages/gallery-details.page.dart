import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GallerieDetailPage extends StatefulWidget {
  final String k;

  GallerieDetailPage(this.k);

  @override
  _GallerieDetailPageState createState() => _GallerieDetailPageState();
}

class _GallerieDetailPageState extends State<GallerieDetailPage> {
  var GallerieData;
  int currentPage = 1;
  int size = 10;
  int totalPages = 0;
  ScrollController _scrollController = ScrollController();
  List<dynamic> hits = [];

  @override
  void initState() {
    super.initState();
    getGalleryData(widget.k);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGalleryData(widget.k);
        }
      }
    });
  }

  void getGalleryData(String k) {
    String apiKey = '40254051-271e5e8a1bf06edebe95679b4';
    String baseUrl = 'https://pixabay.com/api/';
    String requestUrl =
        '$baseUrl?key=$apiKey&q=${k}&page=$currentPage&per_page=$size';

    http.get(Uri.parse(requestUrl)).then((resp) {
      setState(() {
        this.GallerieData = json.decode(resp.body);
        if (currentPage == 1) {
          hits = GallerieData['hits'];
          totalPages = (GallerieData['totalHits'] / size).ceil();
        } else {
          hits.addAll(GallerieData['hits']);
        }
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: totalPages == 0
            ? Text('Pas de résultats')
            : Text("${widget.k}, Page $currentPage/$totalPages"),
      ),
      body: GallerieData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: hits.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Image.network(hits[index]['webformatURL']),
                Text(
                  hits[index]['tags'],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                  color: Colors.white,
                  ),
                ),
              ],
            ),
            color: Colors.blue,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}