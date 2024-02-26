import 'dart:convert';
import 'package:http/http.dart';
import 'utils.dart';

class UserApi {

    String ip = Utils.ip;

    UserApi();

    Future<String> login(String user, String pwd) async {
        Response response = await post(
            Uri.parse('http://$ip/ServletController?action=user&choice=login'),
            body: {
                "username": user,
                "password": pwd
            }
        );
        if(response.statusCode == 200) {
            final dynamic jsonResponse = jsonDecode(response.body);
            String role = jsonResponse['role'];
            if(role == "Client" || role == "Admin") {
                String token = jsonResponse['token'];
                Utils.token = token;
            }
            return role;
        } else {
            return "Error while Logging In";
        }
    }

    Future<String> logout() async {
        Response response = await post(
            Uri.parse('http://$ip/ServletController?action=user&choice=logout'),
            headers: {
                "Authorization" : Utils.token
            }
        );
        if(response.statusCode == 200) {
            final dynamic jsonResponse = jsonDecode(response.body);
            String role = jsonResponse['role'];
            if(role == "Logout successful") {
                Utils.token = '';
            }
            return role;
        } else {
            throw Exception("Error while Logging Out");
        }
    }
}
