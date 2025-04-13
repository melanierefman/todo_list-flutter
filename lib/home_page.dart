import 'package:flutter/material.dart';
import 'add_schedule_page.dart';
import 'schedule_item.dart';
import 'package:objectbox/objectbox.dart';
import 'objectbox_helper.dart';

@Entity()
class Schedule {
  int id = 0;

  String subject;
  String type;
  String date;
  String time;

  Schedule({
    this.id = 0,
    required this.subject,
    required this.type,
    required this.date,
    required this.time,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Schedule> schedules = [];
  late ObjectBoxHelper objectBox;

  @override
  void initState() {
    super.initState();
    initObjectBox();
  }

  void initObjectBox() async {
    objectBox = await ObjectBoxHelper.create();
    setState(() {
      schedules = objectBox.getAllSchedules();
    });
  }

  void _navigateToForm({Schedule? schedule}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditSchedulePage(schedule: schedule)),
    );

    if (result != null && result is Schedule) {
      setState(() {
        if (result.id == 0) {
          objectBox.addSchedule(result);
        } else {
          objectBox.updateSchedule(result);
        }
        schedules = objectBox.getAllSchedules();
      });
    }
  }

  void _deleteSchedule(Schedule schedule) {
    setState(() {
      objectBox.deleteSchedule(schedule.id);
      schedules = objectBox.getAllSchedules();
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
            onEdit: () => _navigateToForm(schedule: schedules[index]),
            onDelete: () => _deleteSchedule(schedules[index]),
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