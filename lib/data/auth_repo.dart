import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepo{

  final baseURL="https://accurate.accuratess.com:8001/graphql";

   Future<String?> login(String username , String password) async
   {
     final String loginMutation=
       '''
       mutation Login {
     login(input: { username: "$username", password: "$password" }) {
        token
      }
     } 
       ''';

     final requestBody=jsonEncode({
       'query':loginMutation
     });

     final response=await http.post(
         Uri.parse(baseURL),
         headers: {
           'Content-Type': 'application/json',
           'User-Agent': 'PostmanClient/11.17.1(AppId=4d81121b-0595-46d4-8f31-a955491958b6)',
         },
       body: requestBody,
     );

     if(response.statusCode==200){
       final data=jsonDecode(response.body);
       if (data['errors'] != null) {
         print('Error: ${data['errors']}');
         return null;
       } else {
         print('done login successfully');
         return data['data']['login']['token'];
       }
     }
     else {
       print('Network error: ${response.statusCode}');
       return null;
     }
   }
}