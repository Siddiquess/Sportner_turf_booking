import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporter_turf_booking/home/model/venue_data_model.dart';
import 'package:sporter_turf_booking/utils/global_colors.dart';
import 'package:sporter_turf_booking/utils/global_values.dart';
import 'package:sporter_turf_booking/utils/textstyles.dart';

import '../components/payment_page_component/booking_details_container.dart';
import '../components/payment_page_component/booking_policy.dart';
import '../components/payment_page_component/payment_details_container.dart';
import '../view_model/venue_details_view_model.dart';

class PaymentPageView extends StatelessWidget {
  const PaymentPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final venueData = context.watch<VenueDetailsViewModel>().venueData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Payment",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AppSizes.kHeight20,
            const BookingDetailsContainer(),
            AppSizes.kHeight10,
            PaymentDetailsContainer(venueData: venueData),
            AppSizes.kHeight10,
            const BookingPolicyWidget(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 45,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Proceed to pay"),
        ),
      ),
    );
  }
}
