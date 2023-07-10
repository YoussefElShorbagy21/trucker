import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/Sign%20Up%20Screen/verfiy_screen.dart';
import 'package:login/shared/components/constants.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/select_photo_options_screen.dart';
import '../Login Screen/loginScreen.dart';
import 'OrDivider.dart';
import 'Social_Icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RegisterScreenScreen extends StatefulWidget {
  @override
  State<RegisterScreenScreen> createState() => _RegisterScreenScreenState();
}

class _RegisterScreenScreenState extends State<RegisterScreenScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  var fullNameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var phoneController = TextEditingController();

  //servier proiver
  var fullNameControllerS = TextEditingController();

  var emailControllerS = TextEditingController();

  var passwordControllerS = TextEditingController();

  var confirmPasswordControllerS = TextEditingController();

  var phoneControllerS = TextEditingController();

  void checkConnectivity(context) async {
    var result = await Connectivity().checkConnectivity();
    print(result);
    if (result == ConnectivityResult.none) {
      print('snakbar');
      dynamic snackBar = SnackBar(
        margin: const EdgeInsets.all(50),
        duration: const Duration(seconds: 5),
        shape: const StadiumBorder(),
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(
          'Check Your Connection'.tr(context),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    }
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    String role = 'customer';
    String roleC = 'customer';
    String roleS = 'service_provider';
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          final snackBar = SnackBar(
            margin: const EdgeInsets.all(50),
            duration: const Duration(seconds: 5),
            shape: const StadiumBorder(),
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            content: Text(
              state.model.status,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
          scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
          if (state.model.status == "success") {
            print(role);
            navigateFish(
                context,
                VerifyScreen(
                  state.model.token,
                  idR: state.model.userSignupModel.id,
                ));
          }
        } else if (state is RegisterErrorState) {
          final snackBar = SnackBar(
            margin: const EdgeInsets.all(50),
            duration: const Duration(seconds: 5),
            shape: const StadiumBorder(),
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text(
              state.error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
          scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              if (snapshot.data == ConnectivityResult.none) {
                print(snapshot.data);
                dynamic snackBar = SnackBar(
                  margin: const EdgeInsets.all(50),
                  duration: const Duration(seconds: 5),
                  shape: const StadiumBorder(),
                  elevation: 5,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text(
                    'Check Your Connection'.tr(context),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
                scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
              }
              return ScaffoldMessenger(
                key: scaffoldMessengerKey,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: ColorManager.white,
                    elevation: 0,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TitleRegister'.tr(context),
                          style: TextStyle(
                            color: ColorManager.black,
                            fontFamily: FontConstants.fontFamily,
                            fontSize: FontSize.s24,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        Text(
                          'subTitleRegister'.tr(context),
                          style: TextStyle(
                            color: ColorManager.gery,
                            fontFamily: FontConstants.fontFamily,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.medium,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 1.2,
                          child: ContainedTabBarView(
                            tabBarProperties: TabBarProperties(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: ColorManager.cGold,
                              position: TabBarPosition.top,
                              alignment: TabBarAlignment.start,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey[400],
                              background: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                              ),
                            ),
                            tabs: [
                              Text('Customer'.tr(context)),
                              Text('service_provider'.tr(context)),
                            ],
                            views: [
                              SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText:
                                                'register_fullName'.tr(context),
                                            prefixIcon: Icon(
                                              Icons.person_outlined,
                                              color: ColorManager.gery,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: fullNameController,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "register_fullName_error"
                                                .tr(context);
                                          } else if (!value.isValidUserName()) {
                                            return "register_fullName_error"
                                                .tr(context);
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText:
                                                'register_email'.tr(context),
                                            prefixIcon: const Icon(
                                                Icons.email_outlined),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !value.isValidEmail()) {
                                            return "register_email_error"
                                                .tr(context);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                      ),
                                      TextFormField(
                                        obscureText: RegisterCubit.get(context)
                                            .isPasswordShown,
                                        decoration: InputDecoration(
                                            labelText:
                                                'register_password'.tr(context),
                                            prefixIcon: const Icon(
                                                Icons.lock_outline_sharp),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                RegisterCubit.get(context)
                                                    .changePasswordVisibility();
                                              },
                                              icon: Icon(
                                                  RegisterCubit.get(context)
                                                      .suffix),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (value) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            RegisterCubit.get(context)
                                                .userSignup(
                                                    name:
                                                        fullNameController.text,
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                    confirmPassword:
                                                        confirmPasswordController
                                                            .text,
                                                    phone: phoneController.text,
                                                    role: role);
                                          }
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.isValidPassword()) {
                                            return "register_password_error"
                                                .tr(context);
                                          } else if (value.length < 8) {
                                            return "invalid_password"
                                                .tr(context);
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                      ),
                                      TextFormField(
                                        obscureText: RegisterCubit.get(context)
                                            .isPasswordShown,
                                        decoration: InputDecoration(
                                            labelText: 'register_conPassword'
                                                .tr(context),
                                            prefixIcon: const Icon(
                                                Icons.lock_outline_sharp),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                RegisterCubit.get(context)
                                                    .changePasswordVisibility();
                                              },
                                              icon: Icon(
                                                  RegisterCubit.get(context)
                                                      .suffix),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: confirmPasswordController,
                                        textInputAction: TextInputAction.done,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (value) {
                                          return value !=
                                                      passwordController.text ||
                                                  value!.isEmpty
                                              ? 'register_conPassword_error'
                                                  .tr(context)
                                              : null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'phone'.tr(context),
                                            prefixIcon: const Icon(Icons.phone),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: phoneController,
                                        keyboardType: TextInputType.phone,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "phone_error".tr(context);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                25,
                                      ),
                                      Conditional.single(
                                          context: context,
                                          conditionBuilder:
                                              (BuildContext context) => state
                                                  is! RegisterLoadingState,
                                          widgetBuilder: (context) {
                                            return Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        35,
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    RegisterCubit.get(context)
                                                        .userSignup(
                                                            name:
                                                                fullNameController
                                                                    .text,
                                                            email:
                                                                emailController
                                                                    .text,
                                                            password:
                                                                passwordController
                                                                    .text,
                                                            confirmPassword:
                                                                confirmPasswordController
                                                                    .text,
                                                            phone:
                                                                phoneController
                                                                    .text,
                                                            role: role);
                                                  }
                                                },
                                                style: TextButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  backgroundColor:
                                                      ColorManager.black,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 14),
                                                ),
                                                child: Text(
                                                  'Sign Up'.tr(context),
                                                  style: TextStyle(
                                                    color: ColorManager.white,
                                                    fontFamily: FontConstants
                                                        .fontFamily,
                                                    fontSize: FontSize.s22,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .semiBold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          fallbackBuilder: (context) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }),
                                      const OrDivider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SocialIcons(
                                              iconSource:
                                                  "assets/icons/facebook.svg",
                                              press: () {
                                                print("facebook");
                                              }),
                                          SocialIcons(
                                              iconSource:
                                                  "assets/icons/twitter.svg",
                                              press: () {
                                                print("twitter");
                                              }),
                                          SocialIcons(
                                              iconSource:
                                                  "assets/icons/google-plus.svg",
                                              press: () {
                                                print("google");
                                              })
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                60,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'already_have_account'.tr(context),
                                            style: TextStyle(
                                              color: ColorManager.black,
                                              fontFamily:
                                                  FontConstants.fontFamily,
                                              fontSize: FontSize.s14,
                                              fontWeight:
                                                  FontWeightManager.medium,
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()));
                                              },
                                              child: Text(
                                                  'login_button'.tr(context))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Form(
                                  key: formKey1,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText:
                                                'register_fullName'.tr(context),
                                            prefixIcon: Icon(
                                              Icons.person_outlined,
                                              color: ColorManager.gery,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: fullNameControllerS,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "register_fullName_error"
                                                .tr(context);
                                          } else if (!value.isValidUserName()) {
                                            return "register_fullName_error"
                                                .tr(context);
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText:
                                                'register_email'.tr(context),
                                            prefixIcon: const Icon(
                                                Icons.email_outlined),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: emailControllerS,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !value.isValidEmail()) {
                                            return "register_email_error"
                                                .tr(context);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                      ),
                                      TextFormField(
                                        obscureText: RegisterCubit.get(context)
                                            .isPasswordShown,
                                        decoration: InputDecoration(
                                            labelText:
                                                'register_password'.tr(context),
                                            prefixIcon: const Icon(
                                                Icons.lock_outline_sharp),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                RegisterCubit.get(context)
                                                    .changePasswordVisibility();
                                              },
                                              icon: Icon(
                                                  RegisterCubit.get(context)
                                                      .suffix),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: passwordControllerS,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (value) {
                                          if (formKey1.currentState!
                                              .validate()) {
                                            RegisterCubit.get(context).userSignup(
                                                name: fullNameControllerS.text,
                                                email: emailControllerS.text,
                                                password:
                                                    passwordControllerS.text,
                                                confirmPassword:
                                                    confirmPasswordControllerS
                                                        .text,
                                                phone: phoneControllerS.text,
                                                role: role);
                                          }
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.isValidPassword()) {
                                            return "register_password_error"
                                                .tr(context);
                                          } else if (value.length < 8) {
                                            return "invalid_password"
                                                .tr(context);
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                      ),
                                      TextFormField(
                                        obscureText: RegisterCubit.get(context)
                                            .isPasswordShown,
                                        decoration: InputDecoration(
                                            labelText: 'register_conPassword'
                                                .tr(context),
                                            prefixIcon: const Icon(
                                                Icons.lock_outline_sharp),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                RegisterCubit.get(context)
                                                    .changePasswordVisibility();
                                              },
                                              icon: Icon(
                                                  RegisterCubit.get(context)
                                                      .suffix),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: confirmPasswordControllerS,
                                        textInputAction: TextInputAction.done,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (value) {
                                          return value !=
                                                      passwordControllerS
                                                          .text ||
                                                  value!.isEmpty
                                              ? 'register_conPassword_error'
                                                  .tr(context)
                                              : null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'phone'.tr(context),
                                            prefixIcon: const Icon(Icons.phone),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: phoneControllerS,
                                        keyboardType: TextInputType.phone,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "phone_error".tr(context);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'please chose photo card'
                                                .tr(context),
                                            style: TextStyle(
                                                color: ColorManager.gery,
                                                fontSize: 15),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              _showSelectPhotoOptionsNew(
                                                  context);
                                            },
                                            icon: const Icon(
                                                Icons.camera_enhance_rounded),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                            labelText:
                                                'National Id'.tr(context),
                                            prefixIcon: const Icon(
                                                Icons.perm_contact_calendar),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: RegisterCubit.get(context)
                                            .nationalIdController,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please Enter National Id"
                                                .tr(context);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                      ),
                                      TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                            labelText:
                                                'Driving License'.tr(context),
                                            prefixIcon: const Icon(
                                                Icons.local_police_outlined),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            )),
                                        controller: RegisterCubit.get(context)
                                            .drivingLicenseController,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please Enter Driving License"
                                                .tr(context);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                25,
                                      ),
                                      Conditional.single(
                                          context: context,
                                          conditionBuilder:
                                              (BuildContext context) => state
                                                  is! RegisterLoadingState,
                                          widgetBuilder: (context) {
                                            return Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        35,
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  if (formKey1.currentState!
                                                      .validate()) {
                                                    RegisterCubit.get(context).userSignup(
                                                        name:
                                                            fullNameControllerS
                                                                .text,
                                                        email: emailControllerS
                                                            .text,
                                                        password:
                                                            passwordControllerS
                                                                .text,
                                                        confirmPassword:
                                                            confirmPasswordControllerS
                                                                .text,
                                                        phone: phoneControllerS
                                                            .text,
                                                        role: role);
                                                  }
                                                },
                                                style: TextButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  backgroundColor:
                                                      ColorManager.black,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 14),
                                                ),
                                                child: Text(
                                                  'Sign Up'
                                                      .tr(context)
                                                      .tr(context),
                                                  style: TextStyle(
                                                    color: ColorManager.white,
                                                    fontFamily: FontConstants
                                                        .fontFamily,
                                                    fontSize: FontSize.s22,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .semiBold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          fallbackBuilder: (context) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }),
                                      const OrDivider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SocialIcons(
                                              iconSource:
                                                  "assets/icons/facebook.svg",
                                              press: () {
                                                print("facebook");
                                              }),
                                          SocialIcons(
                                              iconSource:
                                                  "assets/icons/twitter.svg",
                                              press: () {
                                                print("twitter");
                                              }),
                                          SocialIcons(
                                              iconSource:
                                                  "assets/icons/google-plus.svg",
                                              press: () {
                                                print("google");
                                              })
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                60,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'already_have_account'.tr(context),
                                            style: TextStyle(
                                              color: ColorManager.black,
                                              fontFamily:
                                                  FontConstants.fontFamily,
                                              fontSize: FontSize.s14,
                                              fontWeight:
                                                  FontWeightManager.medium,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()));
                                            },
                                            child: Text(
                                              'login_button'.tr(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            onChange: (index) {
                              if (index == 1) role = roleS;
                              if (index == 0) role = roleC;
                              print(index);
                              print(role);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

extension StringExtensions on String {
  bool isValidUserName() {
    return RegExp(
            r'^[a-zA-Z0-9 ]([._-](?![._-])|[a-zA-Z0-9 ]){3,18}[a-zA-Z0-9 ]$')
        .hasMatch(this);
  }

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$')
        .hasMatch(this);
  }
}

void _showSelectPhotoOptionsNew(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectPhotoOptionsScreen(
              onTap: RegisterCubit.get(context).getPostImageOcr,
            ),
          );
        }),
  );
}
