abstract class BasePowerConsumption {
  @override
  String toString() {
    return super.toString();
  }
}

class PowerConsumption implements BasePowerConsumption {
  final DateTime date;
  final double consumption;

  PowerConsumption(this.date, this.consumption);
  PowerConsumption.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['date']),
        consumption = double.parse(json['consumption'] as String);
  @override
  String toString() {
    return 'PowerConsumption Instance: $date $consumption';
  }
}

class MonthlyPowerConsumption implements BasePowerConsumption {
  final DateTime date;
  final double consumption;

  MonthlyPowerConsumption(this.date, this.consumption);
  MonthlyPowerConsumption.fromJson(Map<String, dynamic> json, year)
      : date = DateTime(year, json['month']),
        consumption = double.parse(json['consumption'] as String);
  @override
  String toString() {
    return 'MonthlyPowerConsumption Instance: $date $consumption';
  }
}
