import 'package:flutter/material.dart';

class Company extends ChangeNotifier {
  String id;
  String ownerId;
  String name;
  String description;
  List<String> workDays = [];

  TimeOfDay workDayStartTime;
  TimeOfDay workDayEndTime;
  List<Stack> stacks = [];
  Company({
    this.ownerId,
    this.id,
    this.name,
    this.description,
    this.workDayEndTime,
    this.workDayStartTime,
  });

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data["id"] = this.id;
    data["ownerId"] = this.ownerId;
    data["name"] = this.name;
    data["description"] = this.description;
    data["workDays"] = this.workDays;
    data["workDayStartTime"] = this.workDayStartTime.toString();
    data["workDayEndTime"] = this.workDayEndTime.toString();
    data["stacks"] = this.stacks.map((e) => e.toJson()).toList();
    return data;
  }

  factory Company.fromJson(json) {
    var comp = Company(
      id: json["id"],
      ownerId: json["ownerId"],
      name: json["name"],
      description: json["description"],
      workDayStartTime: json["workDayStartTime"],
      workDayEndTime: json["workDayEndTime"],
    );
    comp.workDays = json["workDays"];
    comp.stacks = (json["stacks"] as List).map((e) => Stack.fromJson(json));
    return comp;
  }

  void addStack({Stack stack}) {
    stacks.add(stack);
    notifyListeners();
  }

  void addWorkDay({String workDay}) {
    this.workDays.add(workDay);
  }

  void removeStackById([String id]) {
    this.stacks.removeWhere((element) => element.id == id);
  }
}

class Stack {
  String id;
  String description;
  String worker;

  Stack({
    this.description,
    this.worker,
    this.id,
  });

  factory Stack.fromJson(json) {
    return Stack(
      id: json["id"],
      description: json["description"],
      worker: json["worker"],
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data["id"] = this.id;
    data["description"] = this.description;
    data["worker"] = this.worker;
    return data;
  }
}
