import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box('mybox');

  void initialData() {
    toDoList = [
      ["My first task", false],
      ["Slide to delete me", false],
    ];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}

class MarkDataBase1 {
  List markList = [];

  final _myBox = Hive.box('mybox');

  void initialData() {
    markList = [
      ["Titration Lab", 94, 1],
      ["Slide to delete me", 100, 2],
    ];
  }

  void loadData() {
    markList = _myBox.get("MARKCALC1");
  }

  void updateDataBase() {
    _myBox.put("MARKCALC1", markList);
  }
}

class MarkDataBase2 {
  List markList = [];

  final _myBox = Hive.box('mybox');

  void initialData() {
    markList = [
      ["Titration Lab", 94, 1],
      ["Slide to delete me", 100, 2],
    ];
  }

  void loadData() {
    markList = _myBox.get("MARKCALC2");
  }

  void updateDataBase() {
    _myBox.put("MARKCALC2", markList);
  }
}

class MarkDataBase3 {
  List markList = [];

  final _myBox = Hive.box('mybox');

  void initialData() {
    markList = [
      ["Titration Lab", 94, 1],
      ["Slide to delete me", 100, 2],
    ];
  }

  void loadData() {
    markList = _myBox.get("MARKCALC3");
  }

  void updateDataBase() {
    _myBox.put("MARKCALC3", markList);
  }
}

class MarkDataBase4 {
  List markList = [];

  final _myBox = Hive.box('mybox');

  void initialData() {
    markList = [
      ["Titration Lab", 94, 1],
      ["Slide to delete me", 100, 2],
    ];
  }

  void loadData() {
    markList = _myBox.get("MARKCALC4");
  }

  void updateDataBase() {
    _myBox.put("MARKCALC4", markList);
  }
}

class CourseDataBase {
  List courses = [];

  final _myBox = Hive.box('mybox');

  void initialData() {
    courses = ["Course 1", "Course 2", "Course 3", "Course 4"];
  }

  void loadData() {
    courses = _myBox.get("COURSES");
  }

  void updateDataBase() {
    _myBox.put("COURSES", courses);
  }
}

class GradesDataBase {
  List grades = [];

  final _myBox = Hive.box('mybox');

  void initialData() {
    grades = [100, 100, 100, 90];
  }

  void loadData() {
    grades = _myBox.get("GRADES");
  }

  void updateDataBase() {
    _myBox.put("GRADES", grades);
  }
}
