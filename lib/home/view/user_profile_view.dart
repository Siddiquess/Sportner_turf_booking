import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporter_turf_booking/utils/global_colors.dart';
import 'package:sporter_turf_booking/utils/global_values.dart';
import '../../user_registration/view_model/firebase_auth_view_model.dart';
import '../../utils/textstyles.dart';
import '../components/profile_components/profile_settings_list_tile.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text("Profile", style: AppTextStyles.appbarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _userProfile(),
                AppSizes.kHeight20,
                Column(
                  children: [
                    ProfileSettings(
                      title: "My Bookings",
                      subtitle: "View all your bookings",
                      icon: Icons.calendar_month,
                      onTap: () {},
                    ),
                    ProfileSettings(
                      title: "Help & Support",
                      subtitle: "Contact us on whatsapp",
                      icon: Icons.help,
                      onTap: () {},
                    ),
                    ProfileSettings(
                      title: "Invite a friend",
                      subtitle: "Share the sportner App",
                      icon: Icons.share,
                      onTap: () {},
                    ),
                    ProfileSettings(
                      title: "Rate us",
                      subtitle: "Rate the Sportner App",
                      icon: Icons.star,
                      onTap: () {},
                    ),
                    ProfileSettings(
                      title: "Logout",
                      icon: Icons.logout,
                      onTap: () {
                        context
                            .read<FirebaseAuthViewModel>()
                            .userLoginStatus(context);
                      },
                    ),
                    ProfileSettings(
                      title: "Delete My Account",
                      icon: Icons.delete_forever,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
            const Text(
              "Version 1.0.0",
              style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            )
          ],
        ),
      ),
    );
  }

  Container _userProfile() {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: AppColors.appColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.white,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/no_user.png"),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Siddique",
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                "+91987654321",
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ],
          ),
          AppSizes.kWidth25,
          AppSizes.kWidth25,
        ],
      ),
    );
  }
}
