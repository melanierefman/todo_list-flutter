import 'package:flutter/material.dart';
import 'home_page.dart';

class ListSchedule {
  String subject;
  String type;
  String date;
  String time;

  ListSchedule({required this.subject, required this.type, required this.date, required this.time});
}

class AddEditSchedulePage extends StatefulWidget {
  final Schedule? schedule;

  AddEditSchedulePage({this.schedule});

  @override
  _AddEditSchedulePageState createState() => _AddEditSchedulePageState();
}

class _AddEditSchedulePageState extends State<AddEditSchedulePage> {
  final _formKey = GlobalKey<FormState>();
  String? _subject;
  String? _type;
  String? _date;
  String? _time;

  final List<String> subjects = ['PPB', 'Otomata', 'PWEB'];
  final List<String> types = ['Tugas', 'Ujian', 'Kuis'];

  @override
  void initState() {
    super.initState();
    if (widget.schedule != null) {
      _subject = widget.schedule!.subject;
      _type = widget.schedule!.type;
      _date = widget.schedule!.date;
      _time = widget.schedule!.time;
    }
  }

  void _saveSchedule() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Schedule newSchedule = Schedule(
        subject: _subject!,
        type: _type!,
        date: _date!,
        time: _time!,
      );
      Navigator.pop(context, newSchedule);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.schedule == null ? 'Tambah Jadwal' : 'Edit Jadwal')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _subject,
                items: subjects.map((subject) {
                  return DropdownMenuItem(value: subject, child: Text(subject));
                }).toList(),
                onChanged: (value) => setState(() => _subject = value),
                decoration: InputDecoration(labelText: 'Mata Kuliah'),
                validator: (value) => value == null ? 'Pilih mata kuliah' : null,
              ),
              DropdownButtonFormField<String>(
                value: _type,
                items: types.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => setState(() => _type = value),
                decoration: InputDecoration(labelText: 'Tipe'),
                validator: (value) => value == null ? 'Pilih tipe tugas' : null,
              ),
              TextFormField(
                initialValue: _date,
                decoration: InputDecoration(labelText: 'Tanggal (DD-MM-YYYY)'),
                onSaved: (value) => _date = value,
                validator: (value) => value!.isEmpty ? 'Masukkan tanggal' : null,
              ),
              TextFormField(
                initialValue: _time,
                decoration: InputDecoration(labelText: 'Jam (HH:MM)'),
                onSaved: (value) => _time = value,
                validator: (value) => value!.isEmpty ? 'Masukkan jam' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveSchedule,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}