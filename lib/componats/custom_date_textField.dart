import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_test/core/utills/app_colors.dart';
import 'package:job_test/providers/requests_provider.dart';
import 'package:provider/provider.dart';

import 'date_theme.dart';

class CustomDateTextField extends StatefulWidget {
  const CustomDateTextField({super.key});

  @override
  State<CustomDateTextField> createState() => _CustomDateTextFieldState();

}

class _CustomDateTextFieldState extends State<CustomDateTextField> {

  //This function to show the date picker and set the selected date
 Future<void> selectDate(BuildContext context) async {
   final DateTime? pickedDate = await showDatePicker(context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(2024),
       lastDate: DateTime(2025),
       builder:(BuildContext context, Widget? child) {
         return  DateTheme(child: child,);
       }

   );
   if (pickedDate != null) {
     final TimeOfDay? pickedTime = await showTimePicker(context: context,
       initialTime: TimeOfDay.now(),
       builder:
           (BuildContext context, Widget? child) {
         return DateTheme(child: child,);
       },
     );

     if (pickedTime != null) {
       final DateTime fullDateTime = DateTime(
         pickedDate.year,
         pickedDate.month,
         pickedDate.day,
         pickedTime.hour,
         pickedTime.minute,
       );
       Provider.of<RequestsProvider>(context,listen: false).setSelectedDate(
           DateFormat('yyyy-MM-dd hh:mm:ss').format(fullDateTime));
     }
   }
 }

  @override
  Widget build(BuildContext context) {
    final request=Provider.of<RequestsProvider>(context);
    return TextFormField(
      readOnly: true,
      validator: (data){
       if(data!.isEmpty){
           return "Please Enter Valid date";
       }
       return null;
      },
      controller:TextEditingController(text: request.selectedDate),
      decoration: InputDecoration(
        hintText:"select date",
        suffixIcon: IconButton(
          icon:const Icon(Icons.calendar_today,color: AppColors.gray,size: 20,),// Calendar icon
          onPressed: () {
             selectDate(context);
          },
        ),
        filled: true,
        fillColor: AppColors.lightGray,
        enabledBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color:AppColors.gray),
        ),
        focusedBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color:AppColors.primary),
        ),
        errorBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color:AppColors.primary),),
      ),
    );
  }
}

