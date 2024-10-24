import 'package:flutter/material.dart';
import 'package:job_test/componats/custom_request_text_field.dart';
import 'package:job_test/core/commons.dart';
import 'package:job_test/providers/requests_provider.dart';
import 'package:provider/provider.dart';

class DeliveryTypeTextField extends StatefulWidget {
  const DeliveryTypeTextField({super.key});

  @override
  _DeliveryTypeTextFieldState createState() => _DeliveryTypeTextFieldState();
}

class _DeliveryTypeTextFieldState extends State<DeliveryTypeTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();

    final requestProvider = Provider.of<RequestsProvider>(context, listen: false);
    requestProvider.addListener(() {
      final selectedDeliveryType = requestProvider.selectedDTypeChoice;
      if (selectedDeliveryType != null && controller.text != selectedDeliveryType) {
        controller.text = selectedDeliveryType;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RequestsTextField(
          labelText: 'Delivery Type',
          textController: controller,
          validator: (data) {
            if (data!.isEmpty) {
              return "Please select delivery Type";
            }
            return null;
          },
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  showDeliveryTypeChoices(context);
                },
                icon: const Icon(Icons.arrow_drop_down),
              ),
              Selector<RequestsProvider,String?>(
                selector: (context,delivery)=>delivery.selectedDTypeChoice,
                builder: (context,delivery,child){
                  final delivery= Provider.of<RequestsProvider>(context, listen: false);
                  if(delivery.selectedDTypeChoice!=null){
                     return IconButton(
                        onPressed: () {
                          delivery.deleteSelectedDTypeChoice();
                           controller.clear();
                      },
                       icon: const Icon(Icons.cancel_outlined),
                      );
                      }
                      else{
                          return Container();
                      }
                },
              ),
            ],
          ),

        );

  }
}