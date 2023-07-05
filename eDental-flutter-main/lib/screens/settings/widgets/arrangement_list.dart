import 'package:edental/screens/settings/screens/arrangements_tile.dart';
import 'package:flutter/material.dart';
import 'package:edental/screens/settings/models/arrangement.dart';
import 'package:intl/intl.dart';

class ArrangementsList extends StatefulWidget {
  @override
  _ArrangementsListState createState() => _ArrangementsListState();
}

class _ArrangementsListState extends State<ArrangementsList> {
  List<Arrangement> _arrangements = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customizable List'),
      ),
      body: ListView.builder(
        itemCount: _arrangements.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_arrangements[index].title),
            subtitle:
                Text('Time: ${DateFormat().format(_arrangements[index].time)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newArrangement = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddArrangementScreen()),
          );
          if (newArrangement != null) {
            setState(() {
              _arrangements.add(newArrangement);
            });
          }
        },
      ),
    );
  }
}
