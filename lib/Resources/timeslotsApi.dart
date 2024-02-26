import 'dart:convert';
import 'package:http/http.dart';
import 'utils.dart';

class TimeSlotsApi {

    String ip = Utils.ip;

    TimeSlotsApi();

    Future<List<Slots>> getTimeSlots(String name, String surname, String date) async {
        Response response = await get(
            Uri.parse(
                'http://$ip/ServletController?action=lesson&choice=timeSlots&name=$name&surname=$surname&date=$date'
            ),
            headers: {
                "Authorization": Utils.token
            }
        );
        if(response.statusCode == 200) {
            final List<dynamic> jsonSlots = jsonDecode(response.body);
            final List<Slots> slots = jsonSlots.map((e) => Slots.fromJson(e)).toList();
            return slots;
        } else {
            throw Exception("Error fetching timeSlots");
        }
    }
}

class Slots {
    int start;
    int end;

    Slots({
        required this.start,
        required this.end
    });

    factory Slots.fromJson(Map<String,dynamic> json) => Slots(start: json['start'], end: json['end']);
}
