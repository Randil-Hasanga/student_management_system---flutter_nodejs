import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Dio dio = Dio();
  var _data;

  @override
  void initState() {
    super.initState();
    getStudents();
  }

  Future<void> getStudents() async {
    try {
      Response response = await dio.get(
          "https://react-node-testapp-750b3b55ddda.herokuapp.com/students");

      if (response.statusCode == 200) {
        setState(() {
          _data = response.data;
        });
      } else {
        print("Failed to load data");
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _data != null
          ? ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('ID: ${_data[index]['id']}'),
                    subtitle: Text('Name: ${_data[index]['name']}'),
                    trailing: Text('Age: ${_data[index]['age']}'),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
