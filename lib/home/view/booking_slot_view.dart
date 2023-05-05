import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporter_turf_booking/home/components/turf_details_components/available_sport_widget.dart';
import 'package:sporter_turf_booking/home/view_model/booking_slot_view_model.dart';
import 'package:sporter_turf_booking/utils/global_colors.dart';
import 'package:sporter_turf_booking/utils/global_values.dart';
import 'package:sporter_turf_booking/utils/routes/navigations.dart';
import 'package:sporter_turf_booking/utils/textstyles.dart';
import '../components/booking_slot_components/date_container.dart';
import '../components/booking_slot_components/facility_widget.dart';
import '../components/booking_slot_components/time_manage_widget.dart';
import '../view_model/venue_details_view_model.dart';

class BookingSlotView extends StatelessWidget {
  const BookingSlotView({super.key});

  @override
  Widget build(BuildContext context) {
    final venueData = context.watch<VenueDetailsViewModel>().venueData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<BookingSlotViewModel>().setSelectedSport(-1, "");
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Booking",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvailableSportsWidget(venueData: venueData),
              AppSizes.kHeight20,
              const Divider(thickness: 2, color: AppColors.black),
              AppSizes.kHeight20,
              const FacilityWidget(),
              AppSizes.kHeight20,
              Text("Select Date", style: AppTextStyles.textH2),
              AppSizes.kHeight20,
              const DateContainerWidget(),
              AppSizes.kHeight30,
              const TimeManageWidget()
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BookingSlotBottomBar(),
    );
  }
}

class BookingSlotBottomBar extends StatelessWidget {
  const BookingSlotBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color.fromARGB(67, 158, 158, 158),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total : 1000.00",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.appColor,
                fontSize: 19,
              ),
            ),
            SizedBox(
              height: 44,
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, NavigatorClass.paymentScreen);
                },
                style: ElevatedButton.styleFrom(elevation: 0),
                child: const Text("NEXT"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
