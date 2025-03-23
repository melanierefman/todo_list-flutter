import 'package:flutter/material.dart';
import 'add_schedule_page.dart';
import 'schedule_item.dart';

class Schedule {
  String subject;
  String type;
  String date;
  String time;

  Schedule({required this.subject, required this.type, required this.date, required this.time});
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Schedule> schedules = [];

  void _navigateToForm({Schedule? schedule, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditSchedulePage(schedule: schedule),
      ),
    );

    if (result != null && result is Schedule) {
      setState(() {
        if (index != null) {
          schedules[index] = result;
        } else {
          schedules.add(result);
        }
      });
    }
  }

  void _deleteSchedule(int index) {
    setState(() {
      schedules.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jadwal Kegiatan Kuliah',
        ),
      ),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          return ScheduleItem(
            schedule: schedules[index],
            onEdit: () => _navigateToForm(schedule: schedules[index], index: index),
            onDelete: () => _deleteSchedule(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}