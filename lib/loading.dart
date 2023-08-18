import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loading extends StatefulWidget {
  final String choice;

  const Loading({required this.choice});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isLoading = true;
  bool disposed = false;
  late Map<String, dynamic> postData = {};

  Future<void> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    final url = 'https://jsonplaceholder.typicode.com/posts/1';
    try {
      final response = await http.get(Uri.parse(url));
      if (!disposed && response.statusCode == 200) {
        setState(() {
          postData = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
        print('Error $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();

    @override
    void dispose() {
      disposed = true;
      super.dispose();
    }
  }

  Widget _buildLoadingIndicator() {
    if (isLoading) {
      switch (widget.choice) {
        case 'Shimmer':
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Text('Shimmer Loading'),
                Container(
                  width: 200,
                  height: 20,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Container(
                  width: 150,
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
          );
        case 'Spinner':
          return Container(
            width: 60, 
            height: 60,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          );
        case 'Progress':
          return LinearProgressIndicator(
            semanticsLabel: 'Progress Loading',
          );
        default:
          return CircularProgressIndicator();
      }
    } else {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              children: [
                Text('User ID: ${postData['userId']}'),
                SizedBox(height: 20),
                Text('Post ID: ${postData['id']}'),
                SizedBox(height: 20),
                Text('Title: ${postData['title']}'),
                SizedBox(height: 20),
                Text('Body: ${postData['body']}'),
              ],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Indicator'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            _buildLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
