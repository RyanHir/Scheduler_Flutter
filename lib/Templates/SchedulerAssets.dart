import 'package:scheduler/Constants.dart';

class SchedulerAssets {
  List<List<ModInfo>> gradeSchedule = new List<List<ModInfo>>();
  IndividualSchedule schedule;
  IndividualInfo info;
  int grade;

  SchedulerAssets.fromJson(Map<String, dynamic> input) {
    for (var x in input["table"]) {
      List<ModInfo> cohort = new List<ModInfo>();
      for (var y in x) {
        cohort.add(new ModInfo.fromJson(y));
      }
      gradeSchedule.add(cohort);
    }

    info = new IndividualInfo.fromJson(input["info"]);
    schedule = new IndividualSchedule.fromJson(input["schedule"]);
    grade = int.parse(input["grade"]);
  }
}

class ModInfo {
  String type;
  String color;
  String text;

  ModInfo.fromJson(Map<String, dynamic> input) {
    type = input["type"];
    color = input["color"];
    text = input["text"];
  }
}

class IndividualInfo {
  Map<String, dynamic> info = new Map<String, dynamic>();

  IndividualInfo.fromJson(Map<String, dynamic> input) {
    List<String> keys = input.keys.toList();

    keys.removeWhere((item) => Constants.dataToIgnore.contains(item));

    for (var x in keys) {
      info[x] = input[x];
    }
  }
}

class IndividualSchedule {
  int length;
  String failed;

  IndividualSchedule.fromJson(Map<String, dynamic> input) {
    length = int.parse(input["length"]);
    if (input.containsKey("failed")) {
      failed = input["failed"];
    } else {
      //TODO: Read the Single User Data
    }
  }
}

class MotdInfo {
  String local;
  String global;

  MotdInfo.fromJson(Map<String, dynamic> input) {
    local = input["local"];
    global = input["global"];
  }
}