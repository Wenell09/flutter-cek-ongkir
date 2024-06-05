class CostModel {
  String code;
  String name;
  List<Costs> costs;

  CostModel({
    required this.code,
    required this.name,
    required this.costs,
  });

  factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
        code: json["code"],
        name: json["name"],
        costs: List<Costs>.from(json["costs"].map((x) => Costs.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs.map((x) => x.toJson())),
      };
}

class Costs {
  String service;
  String description;
  List<Cost> cost;

  Costs({
    required this.service,
    required this.description,
    required this.cost,
  });

  factory Costs.fromJson(Map<String, dynamic> json) => Costs(
        service: json["service"],
        description: json["description"],
        cost: List<Cost>.from(json["cost"].map((x) => Cost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost.map((x) => x.toJson())),
      };
}

class Cost {
  int value;
  String etd;
  String note;

  Cost({
    required this.value,
    required this.etd,
    required this.note,
  });

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}
