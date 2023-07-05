import 'package:flutter/material.dart';
import 'package:edental/screens/settings/models/arrangement.dart';
import 'package:intl/intl.dart';

class AddArrangementScreen extends StatefulWidget {
  @override
  _AddArrangementScreenState createState() => _AddArrangementScreenState();
}

class _AddArrangementScreenState extends State<AddArrangementScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  DateTime _time = DateTime.now();
  final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime(2100);
  List<Arrangement> _arrangements = [];

  void _addItem(Arrangement item) {
    setState(() {
      _arrangements.add(item);
    });
  }

  void _deleteItem(Arrangement item) {
    setState(() {
      _arrangements.remove(item);
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _time,
      firstDate: _firstDate,
      lastDate: _lastDate,
    );

    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_time),
      );

      if (time != null) {
        setState(() {
          _time = DateTime(
              picked.year, picked.month, picked.day, time.hour, time.minute);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Vaši termini'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Appointment'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Appointment time:'),
                  TextButton(
                    child: Text(DateFormat('dd.MM.yyyy hh:mm a').format(_time)),
                    onPressed: () {
                      _selectTime(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Add apointment'),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    setState(
                      () {
                        _addItem(Arrangement(_title, _time));
                      },
                    );
                  }
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _arrangements.length,
                  itemBuilder: (context, int index) {
                    final item = _arrangements[index];
                    return ListTile(
                      leading: Icon(Icons.watch_rounded),
                      title: Text(item.title),
                      subtitle: Text(
                          DateFormat('yyyy-MM-dd hh:mm a').format(item.time)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteItem(item);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
