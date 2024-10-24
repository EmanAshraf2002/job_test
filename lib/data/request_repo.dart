import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_test/models/customer_request_model.dart';

class RequestRepo {

  final basUrl = "https://accurate.accuratess.com:8001/graphql";

  Future<CustomerRequestModel?> CreateRequest({required String payeeName,
    required String typeCode, required String deliveryTypeCode,
    required String date, required String notes, required String token,}) async {
    final String requestMutation = '''
     mutation SaveCustomerRequest {
    saveCustomerRequest(
        input: {
            payeeName: "$payeeName",
            typeCode:$typeCode
            deliveryTypeCode:$deliveryTypeCode,
            date: "$date",
            notes:"$notes",
         }
    ) {
        payeeName
        type {
            code
        }
        deliveryType {
            code
        }
        date
        id
        notes
        status {
            code
        }
        customer {
            id
        }    
    }
}
    ''';

    final requestBody = jsonEncode({
      'query': requestMutation
    });

    final response = await http.post(
      Uri.parse(basUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'User-Agent': 'PostmanClient/11.17.1(AppId=4d81121b-0595-46d4-8f31-a955491958b6)',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errors'] != null) {
        print('Error: ${data['errors']}');
        return null;
      } else {
        print('request created successfully');
        return CustomerRequestModel.fromJson(
            data['data']['saveCustomerRequest']);
      }
    }
    else {
      print('Network error: ${response.statusCode}');
      return null;
    }
  }

  Future<List<CustomerRequestModel>?> listCustomerRequests({
    required int customerId,
    required String typeCode,
    required String token,
  }) async {
    final String listRequestsQuery = '''
    query ListCustomerRequests {
      listCustomerRequests(input: { customerId: $customerId, typeCode: "$typeCode" }) {
        data {
            id
            date
            payeeName
            type {
                code
            }
            status {
                code
            }
            deliveryType {
                code
            }
            notes
        }
      }
    }
    ''';


    final requestBody = jsonEncode({
      'query': listRequestsQuery,
    });

    final response = await http.post(
      Uri.parse(basUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'User-Agent': 'PostmanClient/11.17.1(AppId=4d81121b-0595-46d4-8f31-a955491958b6)',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['errors'] != null) {
        print('Error: ${data['errors']}');
        return null;
      } else {
        print('Requests fetched successfully');
        final List<dynamic> requestsList = data['data']['listCustomerRequests']['data'];
        return requestsList.map((json) => CustomerRequestModel.fromJson(json))
            .toList();
      }
    } else {
      print('Network error: ${response.statusCode}');
      return null;
    }
  }

  Future<CustomerRequestModel?> UpdateRequestStatus({required String status,
    required int requestId,required String token}) async
  {
    final String updateRequestMutation='''
        mutation UpdateCustomerRequestStatus {
      updateCustomerRequestStatus(input: { id:$requestId, statusCode:$status}) {
        payeeName
        type {
            code
        }
        deliveryType {
            code
        }
        date
        notes
        status {
            code
        }
        id
        customer {
            id
        }
    }
}
    ''';
    final uRequestBody=jsonEncode({
      'query': updateRequestMutation
    });

    final uResponse=await http.post(Uri.parse(basUrl),
      headers: {
     'Content-Type': 'application/json',
     'Authorization':'Bearer $token',
     'User-Agent': 'PostmanClient/11.17.1(AppId=4d81121b-0595-46d4-8f31-a955491958b6)',
    },
      body: uRequestBody,
    );

    if(uResponse.statusCode ==200){
       final data=jsonDecode(uResponse.body);
       if(data['errors']!=null){
         print('Error: ${data['errors']}');
         return null;
       } else {
         print('request Updated successfully');
         return CustomerRequestModel.fromJson(data['data']['updateCustomerRequestStatus']);
       }
    }
    else {
      print('Network error: ${uResponse.statusCode}');
      return null;
    }

    }

  }
