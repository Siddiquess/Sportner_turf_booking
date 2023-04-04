import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sporter_turf_booking/user_registration/view_model/sign_up_view_model.dart';
import 'package:sporter_turf_booking/utils/keys.dart';
import '../../utils/navigations.dart';
import '../view/otp_page_view.dart';

class FirebaseAuthViewModel with ChangeNotifier {
  final googleSigin = GoogleSignIn();
  GoogleSignInAccount? _user;
  bool _isLoadingOtp = false;
  String otpValue = '';

  bool get isLoadingOtp => _isLoadingOtp;
  GoogleSignInAccount get user => _user!;

  Future firebaseGoogleAuth() async {
    try {
      final googleUser = await googleSigin.signIn();

      if (googleUser == null) {
        return;
      }
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      final sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(GlobalKeys.userLoggedWithGoogle, true);
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  firebaseGoogleLogout() async {
    await googleSigin.disconnect();
    FirebaseAuth.instance.signOut();
  }

  setOtpLoading(bool loadingOtp) {
    _isLoadingOtp = loadingOtp;
    notifyListeners();
  }

  fireBasePhoneAuth(BuildContext context) async {
    setOtpLoading(true);
    String countryCode = "+91";
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:
          countryCode + context.read<SignUpViewModel>().phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        setOtpLoading(false);
      },
      codeSent: (String verificationId, int? resendToken) {
        OtpVerificationPage.verify = verificationId;
        Navigator.pushNamed(context, "/otpRegister");
        setOtpLoading(false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    notifyListeners();
  }

  setOtp(String verificationCode) {
    otpValue = verificationCode;
    notifyListeners();
  }

  clearOTP() {
    otpValue = '';
    notifyListeners();
  }

  userLoginStatus(context) async {
    log("11111111111");
    final navigator = Navigator.of(context);
    final sharedPrefer = await SharedPreferences.getInstance();
    final googleSigup = sharedPrefer.getBool(GlobalKeys.userLoggedWithGoogle);
    final userLoggedin = sharedPrefer.getBool(GlobalKeys.userLoggedIN);
    final userSignedUp = sharedPrefer.getBool(GlobalKeys.userSignedUp);
    if (googleSigup == true) {
      log("222222222");
      sharedPrefer.remove(GlobalKeys.userLoggedWithGoogle);
      await firebaseGoogleLogout();
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    } else if (userLoggedin == true) {
      log("333333333");

      sharedPrefer.remove(GlobalKeys.userLoggedIN);
      sharedPrefer.remove(GlobalKeys.accesToken);
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    } else if (userSignedUp == true) {
      log("4444444444444");

      sharedPrefer.remove(GlobalKeys.userSignedUp);
      sharedPrefer.remove(GlobalKeys.accesToken);
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    }
  }
}
