# Simple Application - Using ObjectBox for Local Database

## Identity  
- **Name:** Melanie Sayyidina Sabrina Refman  
- **NRP:** 5025211029  
- **Class:** PPB C  
- **Course:** PPB

---

## Introduction
This project is a simple Flutter application using **ObjectBox** as a local NoSQL database to store, retrieve, update, and delete data. ObjectBox is a high-performance Flutter database designed for easy use and efficient data storage, especially for offline-first apps.

## 1. Add Dependencies

First, add ObjectBox to `pubspec.yaml`.

### a. Add via terminal:

```bash
flutter pub add objectbox objectbox_flutter_libs:any
flutter pub add --dev build_runner objectbox_generator:any
```

### b. Or edit `pubspec.yaml` manually:

```yaml
dependencies:
  flutter:
    sdk: flutter
  objectbox: ^4.1.0
  objectbox_flutter_libs: any

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.15
  objectbox_generator: any
```

After this, run:

```bash
flutter pub get
```

## 2. Create Entity Class

Define a data model with the `@Entity()` annotation.

```dart
import 'package:objectbox/objectbox.dart';

@Entity()
class Data {
  @Id()
  int id = 0;
  double height;
  double weight;

  Data({required this.height, required this.weight});
}
```

## 3. Generate ObjectBox Code

Generate `objectbox.g.dart` and `objectbox-model.json` using:

```bash
dart run build_runner build
```

## 4. Create ObjectBox Store

Create a class to initialize and manage the ObjectBox `Store`.

```dart
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'objectbox.g.dart';
import 'data.dart';

class ObjectBox {
  late final Store store;
  late final Box<Data> dataBox;

  ObjectBox._create(this.store) {
    dataBox = Box<Data>(store);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }
}
```

## 5. Use ObjectBox in The Application  

The following example shows how to use ObjectBox for basic CRUD operations, based on the `ObjectBoxHelper` class.

```dart
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

  // Retrieve all schedules
  List<Schedule> getAllSchedules() => scheduleBox.getAll();

  // Insert a new schedule
  void addSchedule(Schedule schedule) {
    scheduleBox.put(schedule);
  }

  // Update an existing schedule
  void updateSchedule(Schedule schedule) {
    if (schedule.id != 0 && scheduleBox.contains(schedule.id)) {
      scheduleBox.put(schedule);
    }
  }

  // Delete a schedule by id
  void deleteSchedule(int id) {
    scheduleBox.remove(id);
  }
}
```

## Reference
- [ObjectBox — Getting Started](https://docs.objectbox.io/getting-started)
