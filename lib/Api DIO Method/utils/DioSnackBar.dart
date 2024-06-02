import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

showCustomSnackBar(BuildContext context){
  return showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(message: "Somthing Went Wrong ,Please Check Your Internet Connection")
  );
}