import 'package:flutter/material.dart';
import 'package:job_test/providers/requests_provider.dart';
import 'package:provider/provider.dart';

import '../componats/request_item.dart';
import '../core/commons.dart';
import '../core/routes/app_routes.dart';
import '../core/utills/app_colors.dart';
import '../core/utills/app_textStyls.dart';

class AllRequestsScreen extends StatefulWidget {
  const AllRequestsScreen({super.key});

  @override
  State<AllRequestsScreen> createState() => _AllRequestsScreenState();
}

class _AllRequestsScreenState extends State<AllRequestsScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   final request = Provider.of<RequestsProvider>(context, listen: false);
  //   request.addListener(() {
  //     request.fetchCustomerRequests(
  //         customerId: request.customerRequestModel!.customerId,
  //         typeCode: request.selectedRTypeChoice ?? '');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final request = Provider.of<RequestsProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          title: Text(
            "Requests",
            style: AppTextStyles.font20.copyWith(
              color: AppColors.primary,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                navigate(
                    context: context, route: AppRoutes.createRequestScreen);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.gray,
                size: 20,
              )),
        ),
        body: request.requests.isEmpty
            ? const Center(child: Text("No requests yet"))
            : ListView.builder(
                itemCount: request.requests.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        RequestItem(
                          customerRequestModel: request.requests[index],
                          index: index + 1,
                        ),
                        const Divider(
                          color: AppColors.black12,
                          thickness: 2,
                          height: 10,
                          endIndent: 10,
                          indent: 10,
                        )
                      ],
                    ),
                  );
                }));
  }
}
