import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporter_turf_booking/data/response/status.dart';
import 'package:sporter_turf_booking/home/view_model/bottom_nav_view_model.dart';
import '../../../utils/global_values.dart';
import '../../view_model/venue_list_view_model.dart';
import 'home_components.dart';
import '../venue_card_widget.dart';

class HomeNearestTurfWidget extends StatelessWidget {
  const HomeNearestTurfWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        HomeComponents.viewAllText(
          lText: "Nearest Turf",
          onPressed: () {
            context.read<BottomNavViewModel>().changeBottomNavindex(1);
          },
        ),
        AppSizes.kHeight20,
        SizedBox(
          height: size.height * 0.25,
          child: Row(
            children: [
              Consumer<VenueListViewModel>(
                builder: (context, value, child) {
                  switch (value.venuDataList.status) {
                    case Status.completed:
                      final venuDataList = value.venuDataList.data;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: venuDataList!.length > 5
                              ? 5
                              : venuDataList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: VenueCardWidget(
                                venueData: venuDataList[index],
                              ),
                            );
                          },
                        ),
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
