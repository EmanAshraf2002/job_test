import 'package:flutter/material.dart';
import 'package:job_test/componats/custom_request_text_field.dart';
import 'package:job_test/core/commons.dart';
import 'package:job_test/core/utills/app_colors.dart';
import 'package:job_test/providers/requests_provider.dart';
import 'package:provider/provider.dart';


class RequestTypeTextField extends StatefulWidget {
  const RequestTypeTextField({super.key});

  @override
  _RequestTypeTextFieldState createState() => _RequestTypeTextFieldState();
}

class _RequestTypeTextFieldState extends State<RequestTypeTextField> {
  late TextEditingController controller;


  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    final requestProvider = Provider.of<RequestsProvider>(context, listen: false);
    requestProvider.addListener(() {
      final selectedRequestType = requestProvider.selectedRTypeChoice;
      if (selectedRequestType != null && controller.text != selectedRequestType) {
        controller.text = selectedRequestType;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RequestsTextField(
          labelText: 'Request Type',
          textController: controller,
          validator: (data) {
            if (data!.isEmpty) {
              return "Please select request Type";
            }
            return null;
          },
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  showRequestTypeChoices(context);
                },
                icon: const Icon(Icons.arrow_drop_down,),
              ),
                Selector<RequestsProvider,String?>(
                    selector:(context,request)=>request.selectedRTypeChoice,
                    builder:(context,request,child){
                      final request=Provider.of<RequestsProvider>(context,listen: false);
                   if(request.selectedRTypeChoice !=null)
                     {
                      return IconButton(
                        onPressed: () {
                          request.deleteSelectedRTypeChoice();
                          controller.clear();
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      );
                    }
                   else{
                     return Container();
                   }
                },
                )

            ],
          ),
        );
  }
}