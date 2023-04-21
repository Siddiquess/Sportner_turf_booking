import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporter_turf_booking/home/view_model/booking_slot_view_model.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class TimeManageWidget extends StatelessWidget {
  const TimeManageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "From",
              style: AppTextStyles.textH2,
            ),
            AppSizes.kHeight20,
            _timeContainer(context, isFrom: true),
          ],
        ),
        Container(
          height: 90,
          width: 1.5,
          color: AppColors.black,
        ),
        Column(
          children: [
            Text(
              "To",
              style: AppTextStyles.textH2,
            ),
            AppSizes.kHeight20,
            _timeContainer(context, isFrom: false)
          ],
        )
      ],
    );
  }

  Widget _timeContainer(BuildContext context, {required bool isFrom}) {
    final bookingSlotViewModel = context.watch<BookingSlotViewModel>();
    String chosenTime = isFrom
        ? bookingSlotViewModel.selectedTimeFrom
        : bookingSlotViewModel.selectedTimeTo;
    return GestureDetector(
      onTap: () async {
        final selectedTime = await showTimePicker(
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AppColors.appColor,
                buttonTheme: const ButtonThemeData(
                    textTheme: ButtonTextTheme.primary,
                    buttonColor: AppColors.appColor),
                colorScheme: const ColorScheme.light(primary: AppColors.appColor)
                    .copyWith(secondary: AppColors.appColor),
              ),
              child: child!,
            );
          },
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (selectedTime != null) {
          if (isFrom) {
            bookingSlotViewModel
                .setSelectedTimeFrom(selectedTime.format(context).toString());
          } else {
            bookingSlotViewModel
                .setSelectedTimeTo(selectedTime.format(context).toString());
          }
        }
      },
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.lightGrey
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(chosenTime,
                    style: AppTextStyles.textH4),
                AppSizes.kWidth5,
                const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
