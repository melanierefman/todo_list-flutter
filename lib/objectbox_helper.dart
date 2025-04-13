import 'objectbox.g.dart';
import 'home_page.dart';

class ObjectBoxHelper {
  late final Store store;
  late final Box<Schedule> scheduleBox;

  ObjectBoxHelper._create(this.store) {
    scheduleBox = store.box<Schedule>();
  }

  static Future<ObjectBoxHelper> create() async {
    final store = await openStore();
    return ObjectBoxHelper._create(store);
  }

  List<Schedule> getAllSchedules() => scheduleBox.getAll();

  void addSchedule(Schedule schedule) {
    scheduleBox.put(schedule);
  }

  void updateSchedule(Schedule schedule) {
    if (schedule.id != 0 && scheduleBox.contains(schedule.id)) {
      scheduleBox.put(schedule);
    }
  }

  void deleteSchedule(int id) {
    scheduleBox.remove(id);
  }
}