import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:login/modules/customer/screens/Sign%20Up%20Screen/cubit/register_state.dart';
import 'package:login/modules/customer/screens/Sign%20Up%20Screen/register_screen.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../../../../shared/resources/color_manager.dart';
import '../../../../../shared/resources/font_manager.dart';
import '../../Login Screen/loginScreen.dart';
import '../../Sign Up Screen/cubit/register_cubit.dart';

class UpdatePassword extends StatelessWidget {
  UpdatePassword({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var oldPasswordController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Update Password'.tr(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      obscureText: RegisterCubit.get(context).isPasswordShown,
                      decoration: InputDecoration(
                          labelText: 'old password'.tr(context),
                          prefixIcon: const Icon(Icons.lock_outline_sharp),
                          suffixIcon: IconButton(
                            onPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            icon: Icon(RegisterCubit.get(context).suffix),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          )),
                      controller: oldPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty || value.isValidPassword()) {
                          return "register_password_error".tr(context);
                        } else if (value.length < 8) {
                          return "invalid_password".tr(context);
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      obscureText: RegisterCubit.get(context).isPasswordShown,
                      decoration: InputDecoration(
                          labelText: 'New password'.tr(context),
                          prefixIcon: const Icon(Icons.lock_outline_sharp),
                          suffixIcon: IconButton(
                            onPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            icon: Icon(RegisterCubit.get(context).suffix),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          )),
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty || value.isValidPassword()) {
                          return "register_password_error".tr(context);
                        } else if (value.length < 8) {
                          return "invalid_password".tr(context);
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      obscureText: RegisterCubit.get(context).isPasswordShown,
                      decoration: InputDecoration(
                          labelText: 'Confirm New Password'.tr(context),
                          prefixIcon: const Icon(Icons.lock_outline_sharp),
                          suffixIcon: IconButton(
                            onPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            icon: Icon(RegisterCubit.get(context).suffix),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          )),
                      controller: confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        return value != passwordController.text ||
                                value!.isEmpty
                            ? 'register_conPassword_error'.tr(context)
                            : null;
                      },
                    ),
                  ),
                  Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          state is! LoadingUpdatePassword,
                      widgetBuilder: (context) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 35,
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).updatePassword(
                                    oldPassword: oldPasswordController.text,
                                    newPassword: passwordController.text,
                                    newPasswordConfirm:
                                        confirmPasswordController.text,
                                    context: context);
                              }
                            },
                            style: TextButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: ColorManager.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text(
                              "Update".tr(context),
                              style: TextStyle(
                                color: ColorManager.white,
                                fontFamily: FontConstants.fontFamily,
                                fontSize: FontSize.s22,
                                fontWeight: FontWeightManager.semiBold,
                              ),
                            ),
                          ),
                        );
                      },
                      fallbackBuilder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
