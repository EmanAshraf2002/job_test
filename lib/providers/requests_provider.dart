import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_test/core/cachehelper/cache_helper.dart';
import 'package:job_test/data/request_repo.dart';
import 'package:job_test/models/customer_request_model.dart';

class RequestsProvider extends ChangeNotifier {

  final RequestRepo requestRepo = RequestRepo();
  GlobalKey<FormState> createRequestKey = GlobalKey<FormState>();
  final TextEditingController payeeNameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  static const Map<String, String> requestTypeMap = {
    'PMNT': 'PMNT',
    'RTRN': 'RTRN',
    'MTRL': 'MTRL',
  };

  static const Map<String, String> deliveryTypeMap = {
    'OFFICE': 'OFFICE',
    'DELIVERYAGENT': 'DELIVERYAGENT',
  };

  String? _selectedRTypeChoice;

  String? get selectedRTypeChoice => _selectedRTypeChoice;

  void setSelectedRTypeChoice(String choice) {
    _selectedRTypeChoice = requestTypeMap[choice];
    notifyListeners();
  }

  void deleteSelectedRTypeChoice() {
    _selectedRTypeChoice = null;
    notifyListeners();
  }

  String? _selectedDTypeChoice;

  String? get selectedDTypeChoice => _selectedDTypeChoice;

  void setSelectedDTypeChoice(String choice) {
    _selectedDTypeChoice = deliveryTypeMap[choice];
    notifyListeners();
  }

  void deleteSelectedDTypeChoice() {
    _selectedDTypeChoice = null;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  CustomerRequestModel? _customerRequestModel;

  CustomerRequestModel? get customerRequestModel => _customerRequestModel;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<CustomerRequestModel> requests = [];
  //Create Request
  Future<bool> createRequest() async {
    _isLoading = true;
    notifyListeners();
    try {
      _customerRequestModel = await requestRepo.CreateRequest(
        payeeName: payeeNameController.text,
        typeCode: selectedRTypeChoice!,
        deliveryTypeCode: selectedDTypeChoice!,
        date: selectedDate,
        notes: notesController.text,
        token: CacheHelper().getData(key: 'token'),
      );
      if (_customerRequestModel != null) {
        requests.add(_customerRequestModel!);
        final customerId = _customerRequestModel!.customerId;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _errorMessage = "Failed to create request";
        notifyListeners();
        return false;
      }
    }
    catch (error) {
      _isLoading = false;
      _errorMessage = "Error: $error";
      notifyListeners();
      return false;
    }
  }
  //get requests
  Future<void> fetchCustomerRequests({required int customerId,required String typeCode}) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try{
      final fetchedRequests=await requestRepo.listCustomerRequests(
          customerId: customerId,
          typeCode: typeCode,
          token: CacheHelper().getData(key: 'token'));
      if(fetchedRequests!=null){
        requests=fetchedRequests;
        notifyListeners();
      }
      else {
        _errorMessage = "Failed to fetch customer requests.";
      }
    }
    catch(e){
      _isLoading=false;
      _errorMessage="Error: $e";
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }


  String _selectedDate = '';

  setDefaultDate() {
    _selectedDate = getTodayDate();
  }

  String getTodayDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    return formatter.format(now);
  }

  String get selectedDate => _selectedDate; // Getter for selected date

  void setSelectedDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  CustomerRequestModel? _currentRequest;
  CustomerRequestModel? get currentRequest => _currentRequest;
  void setCurrentRequest(CustomerRequestModel request) {
    _currentRequest = request;
    notifyListeners();
  }
 // cancel Request
  Future<void> canselRequest(int requestId) async {
    _isLoading = true;
    _errorMessage=null;
    notifyListeners();
    try {
      final updatedRequest = await requestRepo.UpdateRequestStatus(
          status:'CANCELLED',
          requestId:requestId,
          token:CacheHelper().getData(key: 'token')
      );
      if (updatedRequest != null) {
        final index = requests.indexWhere((request) => request.id == requestId);
        if (index != -1) {
          requests[index] = updatedRequest;
        } else {
          print('Request not found in local list.');
        }
        _currentRequest = updatedRequest;

        print('Request canceled successfully.');
      } else {
        _errorMessage = 'Failed to cancel the request.';
      }
    }
    catch (e) {
      _errorMessage = 'An error occurred: $e';
      print(_errorMessage);
    }
    finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void fillRequestData(CustomerRequestModel request) {
    _currentRequest = request;
    payeeNameController.text = request.payeeName;
    notesController.text = request.notes;
    _selectedDate = request.date;
    _selectedRTypeChoice = request.typeCode;
    _selectedDTypeChoice = request.deliveryTypeCode;
    notifyListeners();
  }
  //update function with update mutation
  //Update Request
  // Future<bool> updateRequest() async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     final updatedRequest = await requestRepo.UpdateRequestStatus(
  //       status:'DELIVERED',
  //       requestId:_currentRequest!.id,
  //       token: CacheHelper().getData(key: 'token'),
  //     );
  //     if (updatedRequest != null) {
  //       // Find and replace the existing request in the list with the updated request
  //       final index = requests.indexWhere((r) => r.id == _currentRequest!.id);
  //       if (index != -1) {
  //         requests[index] = updatedRequest;
  //       }
  //       _isLoading = false;
  //       notifyListeners();
  //       return true;
  //     } else {
  //       _isLoading = false;
  //       _errorMessage = "Failed to update request";
  //       notifyListeners();
  //       return false;
  //     }
  //   } catch (error) {
  //     _isLoading = false;
  //     _errorMessage = "Error: $error";
  //     notifyListeners();
  //     return false;
  //   }
  // }


  //update function with save request mutation
  Future<bool> updateRequest2({required int  requestId}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final updatedRequest = await requestRepo.CreateRequest(
          payeeName: payeeNameController.text,
          typeCode:selectedRTypeChoice!,
          deliveryTypeCode:selectedDTypeChoice!,
          date: selectedDate,
          notes:notesController.text,
          token: CacheHelper().getData(key: 'token'));
      if (updatedRequest != null) {
        // Find and replace the existing request in the list with the updated request
        final index = requests.indexWhere((r) => r.id == requestId);
        if (index != -1) {
          requests[index] = updatedRequest;
        }
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _errorMessage = "Failed to update request";
        notifyListeners();
        return false;
      }
    } catch (error) {
      _isLoading = false;
      _errorMessage = "Error: $error";
      notifyListeners();
      return false;
    }
  }

}


