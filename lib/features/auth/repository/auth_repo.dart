import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/common/helpers/db_helper.dart';
import 'package:todo/common/routes/routes.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


final authRepoProvider = Provider((ref){
  return AuthRepo(auth: FirebaseAuth.instance);
});

class AuthRepo {
  final FirebaseAuth auth;

  AuthRepo({required this.auth});

  void verifyOtp({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async{
    try{
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, 
          smsCode: smsCode);
      await auth.signInWithCredential(credential);
      if(!mounted){
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);

      }on FirebaseAuth catch(e){
      showTopSnackBar(
        displayDuration: const Duration(seconds: 1),
        Overlay.of(context),
        CustomSnackBar.error(
          textStyle: appStyle(16, Colors.white, FontWeight.w500),
          message:
          e.toString(),
        ),
      );

}
}

  void sendOtp({
    required BuildContext context,
    required String phone,
    }) async{
        try{
          await auth.verifyPhoneNumber(
            phoneNumber: phone,
              verificationCompleted: (PhoneAuthCredential credential) async {
                await auth.signInWithCredential(credential);
              },
              verificationFailed: (e){
                showTopSnackBar(
                  displayDuration: const Duration(seconds: 1),
                  Overlay.of(context),
                  CustomSnackBar.error(
                    textStyle: appStyle(16, Colors.white, FontWeight.w500),
                    message:
                    e.toString(),
                  ),
                );
              },
              codeSent: (smsCodeId, resendCodeId){
                DBHelper.createUser(1);
                Navigator.pushNamedAndRemoveUntil(context, Routes.otp, (route) => false,
                    arguments: {
                  "phone": phone,
                    "smsCodeId": smsCodeId});
              },
              codeAutoRetrievalTimeout: (String smsCodeId){});
        }on FirebaseAuth catch(e){
            showTopSnackBar(
            displayDuration: const Duration(seconds: 1),
            Overlay.of(context),
            CustomSnackBar.error(
              textStyle: appStyle(16, Colors.white, FontWeight.w500),
              message:
              e.toString(),
            ),
          );



}

}

}