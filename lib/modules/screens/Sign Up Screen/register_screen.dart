import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/homelayout.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/resources/color_manager.dart';
import '../../../shared/resources/font_manager.dart';
import '../Login Screen/loginScreen.dart';
import 'OrDivider.dart';
import 'Social_Icons.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';

class RegisterScreenScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  RegisterScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context,state) {
          if(state is RegisterSuccessState)
          {
            if(state.model.status == "success")
            {
              print('success');
              CacheHelper.saveData(key: 'token', value: state.model.newUser?.id).then((value) =>
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeLayout()))
              }
              );
            }
            else{
              print('error');
              final snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: '     Error!',
                  message: '    ${state.model.message}',
                  contentType: ContentType.failure,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          }
        },
        builder: (context,state)
        {
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Register to get started!',
                          style: TextStyle(
                            color: ColorManager.black,
                            fontFamily: FontConstants.fontFamily,
                            fontSize: FontSize.s24,
                            fontWeight: FontWeightManager.bold,
                          ),),
                        Text('Create your new account',
                          style: TextStyle(
                            color: ColorManager.gery,
                            fontFamily: FontConstants.fontFamily,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.medium,
                          ),),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Full Name',
                                prefixIcon: Icon(Icons.person_outlined,color: ColorManager.gery,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35.0),
                                )
                            ),
                            controller: fullNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter a full name";
                              }else if (!value.isValidUserName())
                              {
                                return "Enter a valid Name";
                              }
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/35,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35.0),
                                )
                            ),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if(value!.isEmpty || !value.isValidEmail())
                              {
                                return "Enter a valid email";
                              }
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/35,
                          ),
                          TextFormField(
                            obscureText: RegisterCubit.get(context).isPasswordShown,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline_sharp),
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    RegisterCubit.get(context).changePasswordVisibility() ;
                                  } ,
                                  icon: Icon(RegisterCubit.get(context).suffix),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35.0),
                                )
                            ),
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value)
                            {
                              if(formKey.currentState!.validate())
                              {
                                RegisterCubit.get(context).userSignup(
                                  name: fullNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword: confirmPasswordController.text,);
                              }
                            },
                            validator: (value) {
                              if(value!.isEmpty || value.isValidPassword())
                              {
                                return "This is a required field";
                              }
                              else if(value.length < 8)
                              {
                                return "Password very short";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/35,
                          ),
                          TextFormField(
                            obscureText: RegisterCubit.get(context).isPasswordShown,
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: const Icon(Icons.lock_outline_sharp),
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    RegisterCubit.get(context).changePasswordVisibility() ;
                                  } ,
                                  icon: Icon(RegisterCubit.get(context).suffix),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35.0),
                                )
                            ),
                            controller: confirmPasswordController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              return value != passwordController.text || value!.isEmpty? 'Not same the password' : null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/20,
                          ),
                          Conditional.single(
                              context: context ,
                              conditionBuilder: (BuildContext  context) => state is! RegisterLoadingState,
                              widgetBuilder: (context){
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width/35,
                                  ),
                                  child: TextButton(
                                    onPressed:(){
                                      if(formKey.currentState!.validate()){
                                        RegisterCubit.get(context).userSignup(
                                            name: fullNameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            confirmPassword: confirmPasswordController.text);
                                      }
                                    } ,
                                    style: TextButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      backgroundColor: ColorManager.black,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                    ),
                                    child:  Text('Login',
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
                                return const Center(child: CircularProgressIndicator()) ;
                              }
                          ),

                          const OrDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialIcons(
                                  iconSource: "assets/icons/facebook.svg",
                                  press: (){
                                    print("facebook");
                                  }
                              ),
                              SocialIcons(
                                  iconSource: "assets/icons/twitter.svg",
                                  press: (){
                                    print("twitter");
                                  }
                              ),
                              SocialIcons(
                                  iconSource: "assets/icons/google-plus.svg",
                                  press: (){
                                    print("google");
                                  }
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontFamily: FontConstants.fontFamily,
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeightManager.medium,
                                ),
                              ),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  LoginScreen()));
                              },
                                  child: const Text('Sign in')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
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
  bool isValidPassword(){
    return RegExp(
        r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$'
    ).hasMatch(this);
  }
}
