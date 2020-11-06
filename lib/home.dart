import 'package:flutter/material.dart';
import 'package:termometer/model/model.dart';
import 'package:termometer/service/netpie2020.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _deviceID = "1c1df2fb-f25b-4f34-8d5d-b81f31c7ef6c";
  String _deviceToken = "nnTTeiUEhZDwMKQzuL6k1AYAFg2x1g8p";

  NETPIE2020 netpie2020;

  bool _led = false;
  String _temp = "";
  String _humid = "";

  @override
  void initState() {
    super.initState();
    // init netpie class
    netpie2020 = new NETPIE2020();
    // read shadow
    Future<Device> termometer = netpie2020.readShadow(_deviceID, _deviceToken);
    termometer.then((value) {
      setState(() {
        _temp = value.data.temperature.toString();
        _humid = value.data.humidity.toString();
        if (value.data.led.toString() == "on") {
          _led = true;
        } else {
          _led = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NETPIE2020"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                (_led == true)
                    ? SizedBox(width: 220, child: Image.asset("assets/on.png"))
                    : SizedBox(
                        width: 220, child: Image.asset("assets/off.png")),
                RaisedButton(
                    child: Text("ON"),
                    onPressed: () {
                      // set led on
                      netpie2020
                          .publish("led", _deviceID, _deviceToken, "on")
                          .then((res) {
                        if (res == true) {
                          setState(() {
                            _led = true;
                          });
                        }
                      });
                    }),
                RaisedButton(
                    child: Text("OFF"),
                    onPressed: () {
                      // set led off
                      netpie2020
                          .publish("led", _deviceID, _deviceToken, "off")
                          .then((res) {
                        if (res == true) {
                          setState(() {
                            _led = false;
                          });
                        }
                      });
                    }),
                Text((_temp == "") ? "Temp = n/a" : "Temp = " + _temp),
                Text((_humid == "") ? "Humid = n/a" : "Humid = " + _humid)
              ]),
        ),
      ),
    );
  }
}
