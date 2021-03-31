import 'package:flutter/material.dart';

const headingStyle = TextStyle(
  fontSize: 30.0,
);

class DeviceInfoScreen extends StatefulWidget {
  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  final _deviceName = 'Rasberry Pi 4';
  String _devicePower = 'Off';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Status'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DataTable(
                columns: [
                  DataColumn(label: Text('Property')),
                  DataColumn(label: Text('Detail')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Device Name')),
                    DataCell(Text(_deviceName))
                  ]),
                  DataRow(
                    cells: [
                      DataCell(Text('Device Power Status')),
                      DataCell(Text(_devicePower))
                    ],
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () => {
                  setState(() {
                    _devicePower = _devicePower == 'Off' ? 'On' : 'Off';
                  })
                },
                child: Text(
                    "Switch ${_devicePower == 'Off' ? 'On' : 'Off'} the Device"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusText extends StatelessWidget {
  const StatusText({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Text(
        text,
        style: headingStyle,
      ),
    );
  }
}
