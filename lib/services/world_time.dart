import 'dart:convert';
import 'dart:js_util';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;

  late bool isDayTime;
  //@override
  Future<void> getTime() async {
    try {
      Response response =
          get('http://worldtimeapi.org/api/timezones/$url' as Uri) as Response;
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      print(now);
      WorldTime({this.location, this.flag, this.url});
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("caught error: $e");
      time = "could not get the time";
    }
  }
}
