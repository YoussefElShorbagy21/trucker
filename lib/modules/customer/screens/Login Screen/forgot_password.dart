import 'package:flutter/material.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forgot Password'.tr(context),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email'.tr(context),
                        prefixIcon: Icon(
                          Icons.email,
                          color: ColorManager.gery,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        )),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'emailAddress'.tr(context);
                      }
                      return null;
                    },
                  ),
                ),
                Conditional.single(
                    context: context,
                    conditionBuilder: (BuildContext context) =>
                        state is! ForgotPasswordLoadingState,
                    widgetBuilder: (context) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 35,
                        ),
                        child: TextButton(
                          onPressed: () {
                            LoginCubit.get(context)
                                .forgotPassword(email: emailController.text);
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: ColorManager.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            "Send".tr(context),
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
          );
        },
      ),
    );
  }
}
