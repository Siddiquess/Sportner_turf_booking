import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporter_turf_booking/user_registration/view_model/firebase_auth_view_model.dart';
import 'package:sporter_turf_booking/user_registration/view_model/sign_up_view_model.dart';
import 'package:sporter_turf_booking/user_registration/view_model/user_login_view_model.dart';
import 'package:sporter_turf_booking/utils/global_colors.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLogin = false,
  });

  final VoidCallback? onPressed;
  final String title;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final userLoginViewModel = context.watch<UserLoginViewModel>();
    final firebaseViewModel = context.watch<FirbaseAuthViewModel>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: MyColors.kGreyColor,
        elevation: 0,
        backgroundColor: MyColors.kButtonColor,
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: userLoginViewModel.isLoading && isLogin ||
                  firebaseViewModel.isLoadingOtp && !isLogin
              ? const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(
                    color: MyColors.kWhiteColor,
                  ),
                )
              : Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
        ),
      ),
    );
  }
}
