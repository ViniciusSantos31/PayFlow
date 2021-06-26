import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  final authController = AuthController();

  Future<void> googleSignOUt(BuildContext context) async {
    GoogleSignIn _googleSignOut = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      final response = await _googleSignOut.signOut();
      authController.setUser(context, null);
    } catch (e) {
      print(e);
    }
  }

  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      final user = UserModel(
        id: response!.id,
        name: response.displayName!,
        photoURL: response.photoUrl,
      );
      authController.setUser(context, user);
      print(response);
    } catch (error) {
      print(error);
      authController.setUser(context, null);
    }
  }
}
