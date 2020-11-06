class Device {
  String deviceid;
  Data data;
  int rev;
  int modified;

  Device({this.deviceid, this.data, this.rev, this.modified});

  Device.fromJson(Map<String, dynamic> json) {
    deviceid = json['deviceid'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    rev = json['rev'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceid'] = this.deviceid;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['rev'] = this.rev;
    data['modified'] = this.modified;
    return data;
  }
}

class Data {
  int humidity;
  String led;
  int temperature;

  Data({this.humidity, this.led, this.temperature});

  Data.fromJson(Map<String, dynamic> json) {
    humidity = json['humidity'];
    led = json['led'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['humidity'] = this.humidity;
    data['led'] = this.led;
    data['temperature'] = this.temperature;
    return data;
  }
}
