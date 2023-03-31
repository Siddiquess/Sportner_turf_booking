import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporter_turf_booking/components/otp_textfield.dart';
import 'package:sporter_turf_booking/consts/global_colors.dart';
import 'package:sporter_turf_booking/consts/global_values.dart';
import 'package:sporter_turf_booking/consts/textstyles.dart';
import 'package:sporter_turf_booking/view_model/sign_up_view_model.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final otpValue =
        Provider.of<SignUpViewModel>(context, listen: false).otpValue;
    final splitOtp = otpValue.split('');
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeight30,
                  Text(
                    "OTP Verification",
                    style: loginHeadingStyle,
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 180,
                      child: Image.asset("assets/otp_pic.png"),
                    ),
                  ),
                  Text(
                    "Enter the verification code we just sent you\non mobile +91998877665",
                    style: TextStyle(
                      color: klightBlackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  kHeight30,
                  const OtpTextfieldWidget(),
                  kHeight30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Resend code",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kButtonColor,
                        ),
                      )
                    ],
                  ),
                  kHeight40,
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed:splitOtp.length != 6? null: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:const Text("Verification Code"),
                                content: Text('Code entered is $otpValue'),
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                      ),
                      child: const Text(
                        "Verify",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
