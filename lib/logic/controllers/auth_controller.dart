import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../../routes/routes.dart';

class AuthController extends GetxController {
  bool isVisibilty = false;
  bool isCheckBox = false;
  var displayUserName = ''.obs;
  var displayUserPhoto = ''.obs;
  var displayUserEmail = ''.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var googleSignIn = GoogleSignIn();


  var isSignedIn = false;
  final GetStorage authBox = GetStorage();

  User? get userProfiloe => auth.currentUser;

  @override
  void onInit() {
    displayUserName.value =
        (userProfiloe != null ? userProfiloe!.displayName : "")!;
    displayUserPhoto.value =
        (userProfiloe != null ? userProfiloe!.photoURL : "https://th.bing.com/th/id/R.30d0be6727f36bd56993d13e620bfac4?rik=4jhFYjeAHSaeuQ&pid=ImgRaw&r=0")!;
    displayUserEmail.value = (userProfiloe != null ? userProfiloe!.email : "")!;

    super.onInit();
  }

  void visibility() {
    isVisibilty = !isVisibilty;

    update();
  }

  void checkBox() {
    isCheckBox = !isCheckBox;

    update();
  }

  void signUpUsingFirebase({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayUserName.value = name;
        auth.currentUser!.updateDisplayName(name);
      });

      update();

      Get.offNamed(Routes.mainScreen);
    } on FirebaseAuthException catch (error) {
      String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (error.code == 'weak-password') {
        message = ' Provided Password is too weak.. ';
      } else if (error.code == 'email-already-in-use') {
        message = ' Account Already exists for that email.. ';
      } else {
        message = error.message.toString();
      }

      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void logInUsingFirebase({
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              displayUserName.value = auth.currentUser!.displayName!);

      isSignedIn = true;
      authBox.write("auth", isSignedIn);

      update();
      Get.offNamed(Routes.mainScreen);
    } on FirebaseAuthException catch (error) {
      String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (error.code == 'user-not-found') {
        message =
            ' Account does not exists for that $email.. Create your account by signing up..';
      } else if (error.code == 'wrong-password') {
        message = ' Invalid Password... PLease try again! ';
      } else {
        message = error.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void googleSinUpApp() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      displayUserName.value = googleUser!.displayName!;
      displayUserPhoto.value = googleUser.photoUrl!;
      displayUserEmail.value = googleUser.email;

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      await auth.signInWithCredential(credential);

      isSignedIn = true;
      authBox.write("auth", isSignedIn);
      update();

      Get.offNamed(Routes.mainScreen);
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  // void faceBookSignUpApp() async {
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   // final accesToken = loginResult.accessToken!.token;
  //   // final credential = FacebookAuthProvider.credential(accesToken);
  //   // await auth.signInWithCredential(credential);
  //
  //   if (loginResult.status == LoginStatus.success) {
  //     final data = await FacebookAuth.instance.getUserData();
  //     faceBookModel = FaceBookModel.fromJson(data);
  //     // displayUserPhoto.value = faceBookModel!.faceBookPhotoModel!.url!;
  //     // displayUserEmail.value = faceBookModel!.email!;
  //     // displayUserName.value = faceBookModel!.name!;
  //     isSignedIn = true;
  //     authBox.write("auth", isSignedIn);
  //     update();
  //     Get.offNamed(Routes.mainScreen);
  //   }
  // }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);

      update();
      Get.back();
    } on FirebaseAuthException catch (error) {
      String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (error.code == 'user-not-found') {
        message =
            ' Account does not exists for that $email.. Create your account by signing up..';
      } else {
        message = error.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void signOutFromApp() async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
      displayUserName.value = '';
      displayUserPhoto.value = '';
      //displayUserEmail.value = '';
      isSignedIn = false;
      authBox.remove("auth");
      update();

      Get.offNamed(Routes.welcomeScreen);
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
