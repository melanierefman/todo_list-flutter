import 'package:flutter/material.dart';
import 'home_page.dart';

class AddEditSchedulePage extends StatefulWidget {
  final Schedule? schedule;

  AddEditSchedulePage({this.schedule});

  @override
  _AddEditSchedulePageState createState() => _AddEditSchedulePageState();
}

class _AddEditSchedulePageState extends State<AddEditSchedulePage> {
  late TextEditingController dateController;
  late TextEditingController timeController;
  String? selectedSubject;
  String? selectedType;

  final List<String> subjects = ['PPB', 'Otomata', 'PWEB'];
  final List<String> types = ['Tugas', 'Ujian', 'Kuis'];

  @override
  void initState() {
    super.initState();
    selectedSubject = widget.schedule?.subject ?? subjects[0];
    selectedType = widget.schedule?.type ?? types[0];
    dateController = TextEditingController(text: widget.schedule?.date ?? '');
    timeController = TextEditingController(text: widget.schedule?.time ?? '');
  }

  void _saveSchedule() {
    final newSchedule = Schedule(
      id: widget.schedule?.id ?? 0,
      subject: selectedSubject!,
      type: selectedType!,
      date: dateController.text,
      time: timeController.text,
    );
    Navigator.pop(context, newSchedule);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.schedule == null ? 'Tambah Jadwal' : 'Edit Jadwal'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedSubject,
              decoration: InputDecoration(labelText: 'Mata Kuliah'),
              items: subjects.map((subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubject = value;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(labelText: 'Tipe'),
              items: types.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Tanggal'),
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(labelText: 'Waktu'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSchedule,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}