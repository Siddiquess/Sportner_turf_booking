import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sporter_turf_booking/home/view_model/booking_slot_view_model.dart';
import 'package:sporter_turf_booking/utils/textstyles.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';

class BookedVenueCard extends StatelessWidget {
  const BookedVenueCard({
    super.key,
    required this.venueName,
    required this.imageUrl,
    required this.sportName,
    required this.facility,
    required this.bookedDate,
    required this.bookedTime,
    required this.bookedPrice,
    required this.district,
    required this.venueID,
  });

  final String venueName;
  final String venueID;
  final String imageUrl;
  final String sportName;
  final String facility;
  final String bookedDate;
  final String bookedTime;
  final String bookedPrice;
  final String district;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Row(
          children: [
            _imageContianer(),
            AppSizes.kWidth10,
            _turfDetailsContainer(size, context)
          ],
        ),
        const Spacer(),
        _cardTrailing(context)
      ],
    );
  }

  Column _cardTrailing(BuildContext context) {
    final formatedDate = DateFormat('d,MMM,y').parse(bookedDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              bookedDate,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: AppColors.black,
              ),
            ),
            Text(
              "₹ $bookedPrice",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        formatedDate.isBefore(DateTime.now())
            ? const Text(
                "Completed",
                style: TextStyle(
                    color: AppColors.appColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: SizedBox(
                  height: 25,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.red,
                    ),
                    onPressed: () async {},
                    child: const Text("Cancel"),
                  ),
                ),
              )
      ],
    );
  }

  Widget _turfDetailsContainer(Size size, BuildContext context) {
    final bookingViewModel = context.read<BookingSlotViewModel>();
    final timeFrom =
        bookingViewModel.convertTo12HourFormat(bookedTime.split("-").first);
    final timeTo =
        bookingViewModel.convertTo12HourFormat(bookedTime.split("-").last);
    return SizedBox(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: size.width * 0.35,
            child: Text(
              venueName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Text(
            "$sportName ($facility)",
            style: AppTextStyles.textH5,
          ),
          Text(
            "$timeFrom-$timeTo",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: AppColors.black,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: AppColors.blue,
              ),
              Text(
                district,
                style: AppTextStyles.textH5grey,
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _imageContianer() {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.lightGrey,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
