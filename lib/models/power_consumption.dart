class PowerConsumption {
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

class PowerConsumptionList {}
