import 'package:flutter/material.dart';
import 'package:varzish/apis/giphy.dart';

class GifScreen extends StatefulWidget {
  @override
  _GifScreenState createState() => _GifScreenState();
}

class _GifScreenState extends State<GifScreen> {
  String? gifUrl;

  @override
  void initState() {
    super.initState();
    fetchGif();
  }

  Future<void> fetchGif() async {
    final url = await GiphyService.fetchGif('abc');
    setState(() {
      gifUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIF Viewer'),
      ),
      body: Container(
        width: 200,
        height: 200,
        child: gifUrl != null
            ? Image.network(gifUrl!) // Display the GIF
            : CircularProgressIndicator(), // Show a loader while fetching
      ),
    );
  }
}
